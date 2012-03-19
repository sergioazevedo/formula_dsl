#encoding: utf-8
class FormulaParser < Parslet::Parser

  rule :space do
    match('\s').repeat(1)
  end

  rule :space? do
    space.maybe
  end

  rule :number do
    match('\d').repeat(1)
  end

  rule :binary_operator do
    match(['+ * /']) | match('-')
  end

  rule :binary_expression do
    number >> space? >> binary_operator >> space? >> number
  end

  rule :expression do
    space? >> binary_expression >> space? >> (binary_operator >> number).maybe
  end

  root :expression

end

#  expression = left_side operator rigth_side

# a side can be:
#   a number
#   another expression

# 1 + 1 => expression (l => 1 op => + r => 1)
# 1 + 1 * 4 => expression ( l => 1 op => + r => { l})