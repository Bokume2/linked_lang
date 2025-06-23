require_relative "base_types"
require_relative "binary_operation"

module LinkedLang
  class BinaryLogicalOperation < BinaryOperation
    protected

    def evalWithBlock(machineContext, &block)
      actual_lop, actual_rop = @lop.eval(machineContext), @rop.eval(machineContext)
      raise TypeError unless actual_lop.is_a?(Boolean) && actual_rop.is_a?(Boolean)
      Boolean.new(yield(actual_lop.value, actual_rop.value))
    end
  end

  class And < BinaryLogicalOperation
    def eval(machineContext)
      evalWithBlock(machineContext) {|l, r| l && r}
    end
  end

  class Or < BinaryLogicalOperation
    def eval(machineContext)
      evalWithBlock(machineContext) {|l, r| l || r}
    end
  end

  class Not < Function
    def initialize(object:)
      raise ArgumentError unless object.is_a?(Function)
      @object = object
    end

    def eval(machineContext)
      actual_object = @object.eval(machineContext)
      raise TypeError unless actual_object.is_a?(Boolean)
      Boolean.new !actual_object.value
    end

    def self.properties
      {"object" => Function}
    end
  end
end
