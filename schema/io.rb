require_relative "base_types"

module LinkedLang
  class Output < Instruction
    def initialize(object:)
      @object = object
    end

    def exec(machineContext)
      print @object.eval(machineContext).value
    end

    def self.properties
      {"object" => Function}
    end
  end

  class Input < Instruction
    def initialize(target:, format:)
      @target = target
      @format = format
    end

    def exec(machineContext)
      machineContext.set_variable(@target.name,
        case @format
        when "number"
          Number.new($stdin.gets.to_i)
        when "string"
          String.new($stdin.gets.chomp)
        end
      ) 
    end

    def self.properties
      {"target" => Variable, "format" => ::String}
    end
  end
end
