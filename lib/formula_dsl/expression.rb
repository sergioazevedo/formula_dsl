#encoding: utf-8

class BinaryOperation
  attr_reader :operator, :left_term, :right_term

  def initialize(operator, left_term, right_term)
    @operator = operator
    @left_term = left_term
    @right_term = right_term
  end

  def apply
    @left_term = @left_term.apply if @left_term.respond_to? :apply
    @right_term = @right_term.apply if @right_term.respond_to? :apply
    operation = BinaryOperationFactory.new(@operator)

    operation.call(@left_term, @right_term)
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
    function = FunctionFactory.new(@name)

    function.call(@args)
  end

  def == (other)
    @name == other.name && @args == other.args
  end
end

module BinaryOperationFactory
  def self.new(operator)
    operation = case operator
                when :+ then ADDITION
                when :- then SUBTRACTION
                when :* then MULTIPLICATION
                when :/ then DIVISION
                end

    operation
  end
end

module FunctionFactory
  def self.new(function_name)
    function = Module.const_get(function_name.upcase)
  end
end

ADDITION    = Proc.new{|left_term, right_term| "#{left_term} + #{right_term}" }
SUBTRACTION = Proc.new{|left_term, right_term| "#{left_term} - #{right_term}" }
MONTH       = Proc.new{|args| "this.#{args.first}.getMonth() + 1" }
YEAR        = Proc.new{|args| "this.#{args.first}.getYear()" }


