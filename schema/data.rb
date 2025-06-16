module LinkedLang
  class Data
    def initialize(value)
      @value = value
    end

    def exec(machineContext)
      @value
    end

    attr_reader :value
  end

  class Number < Data
    def initialize(value)
      unless value.is_a?(Integer) || value.is_a?(Float)
        raise ArgumentError
      end
      super value
    end
  end

  class String < Data
    def initialize(value)
      unless value.is_a?(::String)
        raise ArgumentError
      end
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
