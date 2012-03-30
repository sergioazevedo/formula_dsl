#encoding: utf-8

module FormulaDSL
  module BinaryExpressionFactory

    def self.new(operator)
      operation = case operator
                  when :+ then ::FormulaDSL::BinaryOperations::ADDITION
                  when :- then ::FormulaDSL::BinaryOperations::SUBTRACTION
                  when :* then ::FormulaDSL::BinaryOperations::MULTIPLICATION
                  when :/ then ::FormulaDSL::BinaryOperations::DIVISION
                  end

      operation
    end

  end
end