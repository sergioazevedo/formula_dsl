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
    (number.as(:left) >> space? >> mult_operator >> space? >> number.as(:right)).as(:*)
  end

  rule :division do
    (number.as(:left) >> space? >> div_operator >> space? >> number.as(:right)).as(:/)
  end

  rule :addition do
    (number.as(:left) >> space? >> add_operator >> space? >> number.as(:right)).as(:+)
  end

  rule :subtraction do
    (number.as(:left) >> space? >> sub_operator >> space? >> number.as(:right)).as(:-)
  end

  #expressions
  rule :binary_expression do
    ( addition | subtraction | multiplication | division)
  end

  rule :expression do
    space? >> (binary_expression) >> space?
  end

  root :expression

end

#  expression = left_side operator rigth_side

# a side can be:
#   a number
#   another expression

# 1 + 1 => expression (l => 1 op => + r => 1)
# 1 + 1 * 4 => expression ( l => 1 op => + r => { l})
# 2 * 4 + 2

# l: 2