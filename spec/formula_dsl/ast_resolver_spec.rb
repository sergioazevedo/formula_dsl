#encoding: utf-8
require 'spec_helper'

describe AstResolver do

  let(:parser){ FormulaParser.new }
  let(:resolver){ subject }

  context "Single Expression's" do

    it "should resolve ast '2 + 1' as BinaryOperation" do
      ast = parser.parse('2 + 1')
      expression = resolver.apply( ast )
      expression.should be_a_kind_of BinaryOperation
      expression.operator.should   == :+
      expression.left_term.should  == 2
      expression.right_term.should == 1
    end

    it "should resolve ast '2 + 1 - 4' as BinaryOperation with contains antoher BinaryOperation" do
      ast = parser.parse('2 + 1 - 4')
      expression = resolver.apply( ast )
      expression.should be_a_kind_of BinaryOperation
      expression.left_term.should be_a_kind_of BinaryOperation
      expression.left_term.should be == BinaryOperation.new(:+,2,1)
      expression.right_term.should == 4
      expression.operator.should == :-
    end

    it "should resolve ast 'Month(data) as Function" do
      ast = parser.parse('Month(data)')
      expression = resolver.apply( ast )
      expression.should be_a_kind_of Function
      expression.name.should == 'Month'
      expression.args.should == ['data']

    end

    it "should resolve ast 'Month(data) + Year(data) as Binary operation wich conatins 2 Function as left and right terms" do
      ast = parser.parse('Month(data) + Year(data)')
      expression = resolver.apply( ast )
      expression.should be_a_kind_of BinaryOperation
      expression.operator.should      == :+
      expression.left_term.should be  == Function.new('Month','data')
      expression.right_term.should be == Function.new('Year','data')

    end

    it "should resolve 'Month(data) + \"/\" + Year(data)' as BinaryOperation wich contains Function and another BinaryOperation" do
      ast = parser.parse('Month(data) + "/" + Year(data)')
      expression = resolver.apply( ast )
      expression.should be_a_kind_of BinaryOperation
      expression.operator.should   == :+
      expression.left_term.should  == Function.new('Month','data')
      expression.right_term.should == BinaryOperation.new(:+,'/',Function.new('Year','data'))
    end

  end

end