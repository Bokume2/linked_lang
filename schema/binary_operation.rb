require_relative "base_types"

module LinkedLang
  class BinaryOperation < Function
    def initialize(lop:, rop:)
      raise ArgumentError unless lop.is_a?(Function) && rop.is_a?(Function)
      @lop = lop
      @rop = rop
    end

    def self.properties
      {"lop" => Function, "rop" => Function}
    end
  end
end
