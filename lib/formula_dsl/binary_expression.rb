#encoding: utf-8
module FormulaDSL

  class BinaryExpression
    attr_reader :operator, :left_term, :right_term

    def initialize(operator, left_term, right_term)
      @operator = operator
      @left_term = left_term
      @right_term = right_term
    end

    def apply
      @left_term = @left_term.apply if @left_term.respond_to? :apply
      @right_term = @right_term.apply if @right_term.respond_to? :apply
      operation = BinaryExpressionFactory.new(@operator)

      operation.call(@left_term, @right_term)
    end

    def == (other)
      @operator == other.operator && @left_term == other.left_term && @right_term == other.right_term
    end
  end

end