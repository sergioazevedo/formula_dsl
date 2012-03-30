#encoding: utf-8
require 'spec_helper'

module FormulaDSL
  describe FunctionExpression do
    subject{ FunctionExpression.new('SQRT', 4) }

    specify { should respond_to(:name) }
    specify { should respond_to(:args) }
    specify { should respond_to(:apply) }

    it "should be considered equal to a another Function if that function contains same data" do
      subject.should == FunctionExpression.new('SQRT', 4)
    end

  end
end