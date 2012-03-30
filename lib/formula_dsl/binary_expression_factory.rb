#encoding: utf-8

module FormulaDSL
  class MissingBinaryOperationError < RuntimeError
  end

  module BinaryExpressionFactory

    def self.new(operator)
      operation = case operator
                  when :+ then ::FormulaDSL::BinaryOperations::ADDITION
                  when :- then ::FormulaDSL::BinaryOperations::SUBTRACTION
                  when :* then ::FormulaDSL::BinaryOperations::MULTIPLICATION
                  when :/ then ::FormulaDSL::BinaryOperations::DIVISION
                  else raise MissingBinaryOperationError, "Sorry, but we don't have a implementation for the operator ( #{operator} )."
                  end

      operation
    end

  end
end