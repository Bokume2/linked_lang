require_relative "base_types"

module LinkedLang
  class BinaryOperation < Function
    def initialize(_lop:, _rop:)
      raise ArgumentError unless _lop.is_a?(Function) && _rop.is_a?(Function)
      @lop = _lop
      @rop = _rop
    end

    def self.properties
      {"lop" => Function, "rop" => Function}
    end
  end
end
