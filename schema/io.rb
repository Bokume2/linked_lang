require_relative "base_types"

module LinkedLang
  class Output < Instruction
    def initialize(_object:)
      @object = _object
    end

    def exec(machineContext)
      print @object.eval(machineContext).value
    end

    def self.properties
      {"object" => Function}
    end
  end

  class Input < Instruction
    def initialize(_target:)
      @target = _target
    end

    def exec(machineContext)
      machineContext.set_variable(@target.name, String.new($stdin.gets.chomp)) 
    end

    def self.properties
      {"target" => Variable, "format" => ::String}
    end
  end
end
