#encoding: utf-8
require 'spec_helper'

describe FormulaParser do

  let(:parser){ subject }

  context "Single Expression's" do

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
  end

  context "Composed expression's " do
    it "should recognize a function like 'Month(data)' " do
      ast = parser.parse('Month(data)')
      ast.to_s.should == %Q({:function=>{:name=>"Month"@0, :args=>"data"@6}})
    end

    it "should recognize the expression 'Month(data) - 1' " do
      ast = parser.parse('Month(data) - 1')
      ast.to_s.should == %Q({:-=>{:left=>{:function=>{:name=>"Month"@0, :args=>"data"@6}}, :right=>"1"@14}})
    end

    it "should recognize the expression 'Month(data) * 1' " do
      ast = parser.parse('Month(data) * 1')
      ast.to_s.should == %Q({:*=>{:left=>{:function=>{:name=>"Month"@0, :args=>"data"@6}}, :right=>"1"@14}})
    end

    it "should recognize the expression 'Month(data) / 1' " do
      ast = parser.parse('Month(data) / 1')
      ast.to_s.should == %Q({:/=>{:left=>{:function=>{:name=>"Month"@0, :args=>"data"@6}}, :right=>"1"@14}})
    end
  end


end