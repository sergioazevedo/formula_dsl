#encoding: utf-8

module FormulaDSL
  module BinaryOperations

    ADDITION       = Proc.new{|left_term, right_term| "#{left_term} + #{right_term}" }
    SUBTRACTION    = Proc.new{|left_term, right_term| "#{left_term} - #{right_term}" }
    DIVISION       = Proc.new{|left_term, right_term| "#{left_term} / #{right_term}" }
    MULTIPLICATION = Proc.new{|left_term, right_term| "#{left_term} * #{right_term}" }

  end
end
