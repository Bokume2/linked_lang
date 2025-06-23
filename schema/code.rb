module LinkedLang
  class Code
    def initialize(content)
      @content = content
    end

    def exec(machineContext)
      @content.each do |instruction|
        instruction.exec machineContext
      end
      nil
    end
    
    attr_reader :content
  end
end
