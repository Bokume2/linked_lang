require_relative "base_types"

module LinkedLang
  class Variable < Function
    def initialize(value)
      raise ArgumentError unless name.is_a?(::String)
      @name = value
    end

    def eval(machineContext)
      machineContext.get_variable @name
    end

    attr_reader :name
  end
end
