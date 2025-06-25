require_relative "base_types"

module LinkedLang
  class Conversion < Function
    def initialize(_object:)
      raise ArgumentError unless _object.is_a?(Function)
      @object = _object
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
