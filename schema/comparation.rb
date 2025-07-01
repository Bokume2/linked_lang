require_relative "binary_operation"

module LinkedLang
  class ComparationOperation < BinaryOperation
    protected

    def evalWithBlock(machineContext, cls, &block)
      actual_lop, actual_rop = @lop.eval(machineContext), @rop.eval(machineContext)
      raise TypeError unless (actual_lop.class == actual_rop.class) && actual_lop.is_a?(cls)
      Boolean.new(yield(actual_lop.value, actual_rop.value))
    end
  end

  class Equal < ComparationOperation
    def eval(machineContext)
      evalWithBlock(machineContext, Data) {|l, r| l == r}
    end
  end

  class LessThan < ComparationOperation
    def eval(machineContext)
      evalWithBlock(machineContext, Number) {|l, r| l < r}
    end
  end
end
