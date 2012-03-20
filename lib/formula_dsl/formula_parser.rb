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

  rule :left_term do
    (number).as(:left)
  end

  rule :right_term do
    (addition | number).as(:right)
  end

  rule :addition do
    (left_term >> add_operator >> right_term).as(:+)
  end

  root :addition
end

#  expression = left_side operator rigth_side

# a side can be:
#   a number
#   another expression

# 1 + 1 => expression (l => 1 op => + r => 1)
# 1 + 1 * 4 => expression ( l => 1 op => + r => { l})
# 2 * 4 + 2

# l: 2