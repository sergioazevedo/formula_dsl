#encoding: utf-8
module FormulaDSL
  class Parser < Parslet::Parser

    # Single char rules
    rule(:lparen) { str('(') >> space? }
    rule(:rparen) { str(')') >> space? }
    rule(:comma)  { str(',') >> space? }
    rule(:dot)    { str('.') >> space? }

    # non significant character's
    rule(:space)  { match('\s').repeat(1) }
    rule(:space?) { space.maybe }

    # Literal's
    rule(:number)     { match('\d').repeat(1) }
    rule(:quote)      { match('"') }
    rule(:identifier) { match['\w'].repeat(1) }
    rule(:string)     { quote >> space? >> (str('"').absnt? >> any).repeat(1) >> space? >> quote}

    # Argument
    rule (:argument) { function | identifier | number | string}
    rule (:arglist)  { ( argument >> comma.maybe).repeat }

    # Operators
    rule(:add_operator ) { match(['+']) }
    rule(:sub_operator ) { match('-') }
    rule(:mult_operator) { match(['*']) }
    rule(:div_operator ) { match(['/']) }

    rule :operator do
      add_operator | sub_operator | mult_operator | div_operator
    end

    #binary operations + - / *
    rule :addition do
      ( argument.as(:left) >> space? >> add_operator >> space? >> ( argument ).as(:right) ).as(:+)
    end

    rule :subtraction do
      ( argument.as(:left) >> space? >> sub_operator >> space? >> ( argument ).as(:right) ).as(:-)
    end

    rule :multiplication do
      ( argument.as(:left) >> space? >> mult_operator >> space? >> ( argument ).as(:right) ).as(:*)
    end

    rule :division do
      ( argument.as(:left) >> space? >> div_operator >> space? >> ( argument ).as(:right) ).as(:/)
    end

    rule :function do
      (identifier.as(:name) >> lparen >> arglist.as(:args) >> rparen).as(:function)
    end

    rule :string_concat do
      ( string.as(:left) >> space? >> add_operator >> space? >> ( string ).as(:right) ).as(:+)
    end

    rule :single_expression do
       function | addition | subtraction | multiplication | division | string_concat | number | string
    end

    # expression with other expression (compose expression)
    # Ex: expression >> some_op >> number === [ Mont(data) - 1 ]
    rule :subtraction_expression do
      (single_expression.as(:left) >> space? >> sub_operator >> space? >> ( expression_list | argument).as(:right) ).as(:-)
    end

    rule :addition_expression do
      (single_expression.as(:left) >> space? >> add_operator >> space? >> ( expression_list | argument ).as(:right) ).as(:+)
    end

    rule :multiplication_expression do
      (single_expression.as(:left) >> space? >> mult_operator >> space? >> (expression_list | argument).as(:right) ).as(:*)
    end

    rule :division_expression do
      (single_expression.as(:left) >> space? >> div_operator >> space? >> (expression_list | argument).as(:right) ).as(:/)
    end

    rule :string_concat_expression do
      (single_expression.as(:left) >> space? >> add_operator >> space? >> ( expression_list | string ).as(:right) ).as(:+)
    end

    rule :expression_list do
      addition_expression | subtraction_expression | multiplication_expression | division_expression | string_concat_expression | single_expression
    end

    # Entry Point rule
    root :expression_list
  end
end