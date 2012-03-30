#encoding: utf-8
require 'spec_helper'

module FormulaDSL
  describe FunctionExpressionFactory do
    subject{ FunctionExpressionFactory }

    specify { should respond_to(:new) }

    it "should return a correct function implementation for a given function name" do
      constant = subject.new("month")
      constant.should be FormulaDSL::Functions::MONTH
    end

    it "should raise MissingFunctionError for a not implemented function" do
      lambda{ subject.new("sqrt") }.should raise_error(MissingFunctionError)
    end


    context "with private method #constantize" do
      it "should receive a string with a full qualified function name and return the correspondent Constant" do
        constant = subject.send(:constantize, "FormulaDSL::Functions::MONTH")
        constant.should be FormulaDSL::Functions::MONTH
      end
    end

  end
end