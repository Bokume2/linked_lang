require_relative "binary_operation"

module LinkedLang
  class BinaryArithmeticOperation < BinaryOperation
    protected

    def evalWithBlock(machineContext, &block)
      actual_lop, actual_rop = @lop.eval(machineContext), @rop.eval(machineContext)
      raise TypeError unless actual_lop.is_a?(Number) && actual_rop.is_a?(Number)
      Number.new(yield(actual_lop.value, actual_rop.value))
    end
  end

  class Add < BinaryArithmeticOperation
    def eval(machineContext)
      evalWithBlock(machineContext) {|l, r| l + r}
    end
  end

  class Sub < BinaryArithmeticOperation
    def eval(machineContext)
      evalWithBlock(machineContext) {|l, r| l - r}
    end
  end

  class Mul < BinaryArithmeticOperation
    def eval(machineContext)
      evalWithBlock(machineContext) {|l, r| l * r}
    end
  end

  class Div < BinaryArithmeticOperation
    def eval(machineContext)
      evalWithBlock(machineContext) {|l, r| l / r}
    end
  end

  class Mod < BinaryArithmeticOperation
    def eval(machineContext)
      evalWithBlock(machineContext) {|l, r| l % r}
    end
  end
end
