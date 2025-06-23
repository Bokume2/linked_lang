require_relative "base_types"

module LinkedLang
  class Output < Instruction
    def initialize(object:)
      @object = object
    end

    def exec(machineContext)
      puts @object.eval
    end

    def self.properties
      {"object" => Function}
    end
  end

  class Input < Instruction
    def initialize(object:, format:)
      @object = object
      @format = format
    end

    def exec(machineContext)
      machineContext.set_variable(@object.value,
        case @format
        when "number"
          gets.to_i
        when "string"
          gets.chomp
        end
      ) 
    end

    def self.properties
      {"object" => Variable, "format" => ::String}
    end
  end
end
