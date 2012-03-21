#encoding: utf-8
class FormulaParser < Parslet::Parser

  # Single char rules
  rule(:lparen) { str('(') >> space? }
  rule(:rparen) { str(')') >> space? }
  rule(:comma)  { str(',') >> space? }

  # non significant character's
  rule(:space)  { match('\s').repeat(1) }
  rule(:space?) { space.maybe }

  # Literal's
  rule(:number) { match('\d').repeat(1) }
  rule(:identifier) { match['\w'].repeat(1) }

  # Argument
  rule (:argument) { identifier | number }
  rule (:arglist)  { (argument >> comma.maybe).repeat }

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
    ( number.as(:left) >> space? >> add_operator >> space? >> ( number ).as(:right) ).as(:+)
  end

  rule :subtraction do
    ( number.as(:left) >> space? >> sub_operator >> space? >> ( number ).as(:right) ).as(:-)
  end

  rule :multiplication do
    ( number.as(:left) >> space? >> mult_operator >> space? >> ( number ).as(:right) ).as(:*)
  end

  rule :division do
    ( number.as(:left) >> space? >> div_operator >> space? >> ( number ).as(:right) ).as(:/)
  end

  rule :function do
    (identifier.as(:name) >> lparen >> arglist.as(:args) >> rparen).as(:function)
  end

  rule :single_expression do
    function | addition | subtraction | multiplication | division
  end

  # expression with other expression (compose expression)
  # Ex: expression >> some_op >> number === [ Mont(data) - 1 ]
  rule :subtraction_expression do
    (single_expression.as(:left) >> space? >> sub_operator >> space? >> number.as(:right) ).as(:-)
  end

  rule :addition_expression do
    (single_expression.as(:left) >> space? >> add_operator >> space? >> number.as(:right) ).as(:+)
  end

  rule :multiplication_expression do
    (single_expression.as(:left) >> space? >> mult_operator >> space? >> number.as(:right) ).as(:*)
  end

  rule :division_expression do
    (single_expression.as(:left) >> space? >> div_operator >> space? >> number.as(:right) ).as(:/)
  end

  rule :expression_list do
     addition_expression | subtraction_expression | multiplication_expression | division_expression | single_expression
  end


  # Entry Point rule
  root :expression_list

  # rule :addition do
  #   (number.as(:left) >> space? >> add_operator >> >> space? >> ( single_operations ).as(:right)).as(:+)
  # end

  # rule :multiplication do
  #   (number.as(:left) >> mult_operator >> (multiplication | number).as(:right)).as(:*)
  # end

  # rule :multiplication_expression do
  #   ( ( single_operations ).as(:left) >> add_operator >> (addition | number).as(:right) ).as(:+)
  # end

  # rule :addition_expression do
  #   ( addition >> mult_operator >> (multiplication | number).as(:right) )
  # end

  # rule :expression do
  #    multiplication_expression | addition_expression
  # end

  # rule :single_operations do
  #   addition | multiplication | number
  # end

  # rule :list do
  #   expression | single_operations
  # end

  # root :list
end