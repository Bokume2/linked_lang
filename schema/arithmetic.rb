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

    protected

    def evalWithBlock(machineContext, &block)
      actual_lop, actual_rop = @lop.eval(machineContext), @rop.eval(machineContext)
      raise TypeError unless actual_lop.is_a?(Number) && actual_rop.is_a?(Number)
      Number.new(yield(actual_lop.value, actual_rop.value))
    end
  end

  class Add < BinaryOperation
    def eval(machineContext)
      evalWithBlock(machineContext) {|l, r| l + r}
    end
  end

  class Sub < BinaryOperation
    def eval(machineContext)
      evalWithBlock(machineContext) {|l, r| l - r}
    end
  end

  class Mul < BinaryOperation
    def eval(machineContext)
      evalWithBlock(machineContext) {|l, r| l * r}
    end
  end

  class Div < BinaryOperation
    def eval(machineContext)
      evalWithBlock(machineContext) {|l, r| l / r}
    end
  end

  class Mod < BinaryOperation
    def eval(machineContext)
      evalWithBlock(machineContext) {|l, r| l % r}
    end
  end
end
