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

  rule :operator do
    match( ['+'] )
  end

  rule :expression do
    number >> space? >> operator >> space? >> number
  end

  root :expression

end