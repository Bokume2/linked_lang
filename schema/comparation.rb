require_relative "binary_operation"

module LinkedLang
  class ComparationOperation < BinaryLogicalOperation
    protected

    def evalWithBlock(machineContext, &block)
      actual_lop, actual_rop = @lop.eval(machineContext), @rop.eval(machineContext)
      raise TypeError unless (actual_lop.class == actual_rop.class) && actual_lop.is_a?(Data)
      Boolean.new(yield(actual_lop.value, actual_rop.value))
    end
  end

  class Equal < ComparationOperation
    def eval(machineContext)
      evalWithBlock(machineContext) {|l, r| l == r}
    end
  end

  class LessThan < ComparationOperation
    def eval(machineContext)
      evalWithBlock(machineContext) {|l, r| l < r}
    end
  end
end
