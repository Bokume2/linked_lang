require_relative "base_types"

module LinkedLang
  class ControlStatement < Instruction; end

  class If < ControlStatement
    def initialize(condition:, _then:, _else: Code.new([]))
      _else = Code.new([]) if _else.nil?
      raise ArgumentError unless condition.is_a?(Function) && _then.is_a?(Code) && _else.is_a?(Code)
      @condition = condition
      @then = _then
      @else = _else
    end

    def exec(machineContext)
      actual_condition = @condition.eval(machineContext)
      raise TypeError unless actual_condition.is_a?(Boolean)
      if actual_condition.value
        @then.exec machineContext
      else
        @else.exec machineContext
      end
    end

    def self.properties
      {"condition" => Function, "then" => Code, "else" => Code}
    end
  end

  class While < ControlStatement
    def initialize(condition:, _then:)
      raise ArgumentError unless condition.is_a?(Function) && _then.is_a?(Code)
      @condition = condition
      @then = _then
    end

    def exec(machineContext)
      actual_condition = @condition.eval(machineContext)
      raise TypeError unless actual_condition.is_a?(Boolean)
      while actual_condition.value
        @then.exec machineContext
        actual_condition = @condition.eval(machineContext)
        raise TypeError unless actual_condition.is_a?(Boolean)
      end
    end

    def self.properties
      {"condition" => Function, "then" => Code}
    end
  end
end
