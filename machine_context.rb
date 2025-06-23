require_relative "schema/code"

module LinkedLang
  class MachineContext
    def initialize(code)
      raise ArgumentError unless code.is_a?(Code)
      @code = code
      @pc = 0
      @variables = {}
    end

    def run
      @code.exec self
      nil
    end

    def step
      @code.content[@pc].exec self
      @pc += 1
      nil
    end

    def set_variable(name, value)
      raise ArgumentError unless name.is_a?(::String) && value.is_a?(Data)
      @variables[name] = value
      nil
    end

    def get_variable(name)
      raise %(Undefined Variable "#{name}") unless @variables.keys.include?(name)
      @variables[name]
    end

    attr_reader :code
  end
end
