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
      actual_object = @object.eval(machineContext)
      raise TypeError unless actual_object.is_a?(Number)
      String.new(actual_object.value.to_s)
    end
  end

  class StringToNumber < Conversion
    def eval(machineContext)
      actual_object = @object.eval(machineContext)
      raise TypeError unless actual_object.is_a?(String)
      Number.new(actual_object.value.to_i)
    end
  end
end
