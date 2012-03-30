#encoding: utf-8
require 'spec_helper'

module FormulaDSL
  describe BinaryExpressionFactory do
    subject{ BinaryExpressionFactory }

    specify { should respond_to(:new) }

    it "should be return a ADDITON Proc to + operator " do
      subject.new(:+).should be == FormulaDSL::BinaryOperations::ADDITION
    end

    it "should be return a SUBTRACTION Proc to - operator " do
      subject.new(:-).should be == FormulaDSL::BinaryOperations::SUBTRACTION
    end

    it "should be return a MULTIPLICATON Proc to * operator " do
      subject.new(:*).should be == FormulaDSL::BinaryOperations::MULTIPLICATION
    end

    it "should be return a DIVISION Proc to / operator " do
      subject.new(:/).should be == FormulaDSL::BinaryOperations::DIVISION
    end

  end
end