require "json/ld"

require_relative "constants"
require_relative "schema/base_types"
require_relative "schema/code"
require_relative "schema/data"
require_relative "schema/variable"
require_relative "schema/arithmetic"
require_relative "schema/logical"
require_relative "schema/comparation"
require_relative "schema/bind"
require_relative "schema/io"

class Hash
  def ll_type
    if self[LinkedLang::TYPE_KEY]&.start_with?(LinkedLang::LL_NAMESPACE)
      eval("LinkedLang::" + self[LinkedLang::TYPE_KEY].delete_prefix(LinkedLang::LL_NAMESPACE))
    end
  end

  def ll_properties
    ll_keys = self.keys.filter {|i| i.start_with?(LinkedLang::LL_NAMESPACE)}
    properties = {}
    ll_keys.each {|key| properties[key.delete_prefix(LinkedLang::LL_NAMESPACE)] = self[key]}
    properties
  end

  def get_ll_property(key)
    self[LinkedLang::LL_NAMESPACE + key]
  end

  def has_ll_property?(key)
    self.has_key? LinkedLang::LL_NAMESPACE + key
  end
end

module LinkedLang
  class Parser
    LL_CONTEXT = JSON.parse(File.read("#{__dir__}/context.jsonld"))[CONTEXT_KEY]

    class << self
      def parse(code)
        raw_json = JSON.parse(code)
        raw_json[CONTEXT_KEY] = addContext(raw_json[CONTEXT_KEY])
        ldCode = JSON::LD::API.compact(raw_json, {})
        if ldCode.ll_type == Code
          parse_code ldCode
        end
      end

      private

      def addContext(context)
        if context.nil?
          LL_CONTEXT
        elsif context.is_a?(Hash)
          context.merge(LL_CONTEXT)
        elsif context.is_a?(Array)
          context << LL_CONTEXT
        else
          [context, LL_CONTEXT]
        end
      end

      def parse_something(hash, type)
        if type == Code
          parse_code hash
        elsif type <= Instruction || type <= Function
          raise TypeError unless hash.ll_type <= type
          parse_statement hash
        elsif type.is_a?(Class)
          raise TypeError unless hash[VALUE_KEY].is_a?(type)
          hash[VALUE_KEY]
        end
      end

      def parse_code(hash)
        content = []
        raw_content = hash.get_ll_property("content")
        if raw_content.nil?
          # nothing to do
        elsif raw_content.is_a?(Hash)
          raise TypeError unless raw_content.ll_type <= Instruction
          content = [parse_statement(raw_content)]
        elsif raw_content.is_a?(Array)
          raw_content.each do |item|
            raise TypeError unless item.ll_type <= Instruction
            content << parse_statement(item)
          end
        else
          raise TypeError
        end
        Code.new content
      end

      def parse_statement(hash)
        type = hash.ll_type
        if type < Data || type <= Variable
          return type.new(hash[VALUE_KEY])
        end
        raw_properties = hash.ll_properties
        properties = {}
        type.properties.each do |key, type|
          properties[key.to_sym] = parse_something(raw_properties[key], type)
        end
        type.new(**properties)
      end
    end
  end
end
