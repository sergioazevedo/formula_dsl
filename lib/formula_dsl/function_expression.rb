#encoding: utf-8
module FormulaDSL

  class FunctionExpression
    attr_reader :name, :args
    def initialize(name, *args)
      @name = name
      @args = args
    end

    def apply
      function = FunctionExpressionFactory.new(@name)

      function.call(@args)
    end

    def == (other)
      @name == other.name && @args == other.args
    end
  end

end