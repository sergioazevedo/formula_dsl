#encoding: utf-8
require 'spec_helper'

describe FormulaParser do

  let(:parser){ subject }

    it "should recognize expression '2 + 1' " do
      ast = parser.parse('2 + 1')
      ast.to_s.should == %Q({:+=>{:left=>"2"@0, :right=>"1"@4}})
    end

    it "should recognize expression '2 - 1" do
      ast = parser.parse('2 - 1')
      ast.to_s.should == %Q({:-=>{:left=>"2"@0, :right=>"1"@4}})
    end

    it "should recognize expression '2 * 1" do
      ast = parser.parse('2 * 1')
      ast.to_s.should == %Q({:*=>{:left=>"2"@0, :right=>"1"@4}})
    end

    it "should recognize expression '2 / 2" do
      ast = parser.parse('2 / 2')
      ast.to_s.should == %Q({:/=>{:left=>"2"@0, :right=>"2"@4}})
    end


    # it "should recognize a function like 'Month(data)' " do
    #   ast = parser.parse('Month(data)')
    # end

    # it "should recognize the expression 'Month(data) - 1' " do
    #   ast = parser.parse('Month(data) - 1')
    # end

end