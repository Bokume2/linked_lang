require_relative "base_types"

module LinkedLang
  class Cnversion < Function
    def initialize(object:)
      raise ArgumentError unless object.is_a?(Function)
      @object = object
    end

    def self.properties
      {"object" => Function}
    end
  end

  class NumberToString < Conversion
    def eval(machineContext)
      raise TypeError unless @object.is_a?(Number)
      String.new(@object.value.to_s)
    end
  end

  class StringToNumber < Conversion
    def eval(machineContext)
      raise TypeError unless @object.is_a?(String)
      Number.new(@object.value.to_i)
    end
  end
end
