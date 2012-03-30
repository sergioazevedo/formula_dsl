#encoding: utf-8
require 'spec_helper'

module FormulaDSL
  describe Transformer do

    let(:parser){ Parser.new }
    let(:resolver){ subject }

    context "Resolving Expression's" do

      it "should resolve ast '2 + 1' as BinaryExpression" do
        ast = parser.parse('2 + 1')
        expression = resolver.apply( ast )
        expression.should be_a_kind_of BinaryExpression
        expression.operator.should   == :+
        expression.left_term.should  == 2
        expression.right_term.should == 1
      end

      it "should resolve ast '2 + 1 - 4' as BinaryExpression with contains antoher BinaryExpression" do
        ast = parser.parse('2 + 1 - 4')
        expression = resolver.apply( ast )
        expression.should be_a_kind_of BinaryExpression
        expression.left_term.should be_a_kind_of BinaryExpression
        expression.left_term.should be == BinaryExpression.new(:+,2,1)
        expression.right_term.should == 4
        expression.operator.should == :-
      end

      it "should resolve ast 'Month(data) as FunctionExpression" do
        ast = parser.parse('Month(data)')
        expression = resolver.apply( ast )
        expression.should be_a_kind_of FunctionExpression
        expression.name.should == 'Month'
        expression.args.should == ['data']
      end

      it "should resolve ast 'Month(data) + Year(data) as Binary operation wich conatins 2 FunctionExpression as left and right terms" do
        ast = parser.parse('Month(data) + Year(data)')
        expression = resolver.apply( ast )
        expression.should be_a_kind_of BinaryExpression
        expression.operator.should      == :+
        expression.left_term.should be  == FunctionExpression.new('Month','data')
        expression.right_term.should be == FunctionExpression.new('Year','data')
      end

      it "should resolve 'Month(data) + \"/\" + Year(data)' as BinaryExpression wich contains FunctionExpression and another BinaryExpression" do
        ast = parser.parse('Month(data) + "/" + Year(data)')
        expression = resolver.apply( ast )
        expression.should be_a_kind_of BinaryExpression
        expression.operator.should   == :+
        expression.left_term.should  == FunctionExpression.new('Month','data')
        expression.right_term.should == BinaryExpression.new(:+,"'/'",FunctionExpression.new('Year','data'))
      end

    end
  end

end