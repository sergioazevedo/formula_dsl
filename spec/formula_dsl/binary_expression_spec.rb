#encoding: utf-8
require 'spec_helper'

module FormulaDSL
  describe BinaryExpression do
    subject{ BinaryExpression.new(:+, 3, 2) }

    specify { should respond_to(:operator) }
    specify { should respond_to(:left_term) }
    specify { should respond_to(:right_term) }
    specify { should respond_to(:apply) }

    it "should be considered equal to a another Function if that function contains same data" do
      subject.should == BinaryExpression.new(:+, 3, 2)
    end

  end
end