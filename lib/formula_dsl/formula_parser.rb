#encoding: utf-8
class FormulaParser < Parslet::Parser

  # non significant character's
  rule(:space)  { match('\s').repeat(1) }
  rule(:space?) { space.maybe }

  # Literal's
  rule(:number) { match('\d').repeat(1) }

  # Operators
  rule(:add_operator ) { match(['+']) }
  rule(:sub_operator ) { match('-') }
  rule(:mult_operator) { match(['*']) }
  rule(:div_operator ) { match(['/']) }

  rule :multiplication do
    (number.as(:left) >> mult_operator >> (multiplication | number).as(:right)).as(:*)
  end

  rule :addition do
    (number.as(:left) >> add_operator >> (addition | multiplication | number).as(:right)).as(:+)
  end

  rule :multiplication_expression do
    ( multiplication.as(:left) >> add_operator >> (addition | number).as(:right) ).as(:+)
  end

  rule :addition_expression do
    ( addition >> mult_operator >> (multiplication | number).as(:right) )
  end

  rule :expression do
     multiplication_expression | addition_expression
  end

  rule :single_operations do
    addition | multiplication
  end

  rule :list do
    expression | single_operations
  end

  root :list
end

#  expression = left_side operator rigth_side

# a side can be:
#   a number
#   another expression

# 1 + 1 => expression (l => 1 op => + r => 1)
# 1 + 1 * 4 => expression ( l => 1 op => + r => { l})
# 2 * 4 + 2

# l: 2