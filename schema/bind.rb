require_relative "base_types"

module LinkedLang
  class Bind < Instruction
    def initialize(origin:, target:)
      raise ArgumentError unless origin.is_a?(Function) && target.is_a?(Variable)
      @origin = origin
      @target = target
    end

    def exec(machineContext)
      machineContext.set_variable @target.name, @origin.eval(machineContext)
    end

    def self.properties
      {"origin" => Function, "target" => Variable}
    end
  end
end
