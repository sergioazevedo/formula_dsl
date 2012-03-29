#encoding: utf-8
class Expression
  def execute
    raise RuntimeError, "this is a abstract method and must be implemented by one subclass of Expression"
  end
end

class BinaryOperation
  attr_reader :operator, :left_term, :right_term

  def initialize(operator, left_term, right_term)
    @operator = operator
    @left_term = left_term
    @right_term = right_term
  end

  def apply

  end

  def == (other)
    @operator == other.operator && @left_term == other.left_term && @right_term == other.right_term
  end

end

class Function
  attr_reader :name, :args
  def initialize(name, *args)
    @name = name
    @args = args
  end

  def apply

  end

  def == (other)
    @name == other.name && @args == other.args
  end
end