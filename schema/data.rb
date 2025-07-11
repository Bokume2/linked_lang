require_relative "base_types"

module LinkedLang
  class Data < Function
    def initialize(value)
      @value = value
    end

    def eval(machineContext)
      self
    end

    attr_reader :value
  end

  class Number < Data
    def initialize(value)
      raise ArgumentError unless value.is_a?(Integer) || value.is_a?(Float)
      super value
    end
  end

  class String < Data
    def initialize(value)
      raise ArgumentError unless value.is_a?(::String)
      super value
    end
  end

  class Boolean < Data
    def initialize(value)
      super(
        case value
        when true
          true
        when false
          false
        else
          raise ArgumentError
        end
      )
    end
  end
end
