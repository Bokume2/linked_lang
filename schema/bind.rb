require_relative "base_types"

module LinkedLang
  class Bind < Instruction
    def initialize(_origin:, _target:)
      raise ArgumentError unless _origin.is_a?(Function) && _target.is_a?(Variable)
      @origin = _origin
      @target = _target
    end

    def exec(machineContext)
      machineContext.set_variable @target.name, @origin.eval(machineContext)
    end

    def self.properties
      {"origin" => Function, "target" => Variable}
    end
  end
end
