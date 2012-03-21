#encoding: utf-8
require 'spec_helper'

describe FormulaParser do

  let(:parser){ subject }

  context "For simple expressions (without functions)" do
    # it "should recognize multiply operations" do
    #   ast = parser.parse('2*5')
    #   ast[:*][:left].to_i.should == 2
    #   ast[:*][:right].to_i.should == 5
    # end
    # it "should recognize division operations" do
    #   ast = parser.parse('2/5')
    #   ast[:/][:left].to_i.should == 2
    #   ast[:/][:right].to_i.should == 5
    # end
  #   it "should recognize sum operations" do
  #     ast = parser.parse('2+5')
  #     ast[:+][:left].to_i.should == 2
  #     ast[:+][:right].to_i.should == 5
  #   end
  end

  context "For more complex expressions (without functions)" do
    # it "should recognize 2+5+10" do
    #   ast = parser.parse('2+5+10')
    #   ast[:+][:left].to_i.should == 2
    #   ast[:+][:right].should be_a Hash
    #   ast[:+][:right][:+].should_not nil
    #   ast[:+][:right][:+][:left].to_i.should == 5
    #   ast[:+][:right][:+][:right].to_i.should == 10
    # end

    # it "should recognize 2*5*10" do
    #   ast = parser.parse('2*5*10')
    #   ast[:*][:left].to_i.should == 2
    #   ast[:*][:right].should be_a Hash
    #   ast[:*][:right][:*].should_not nil
    #   ast[:*][:right][:*][:left].to_i.should == 5
    #   ast[:*][:right][:*][:right].to_i.should == 10
    # end

    it "should recognize 2*5+10" do
      # ast = parser.parse('2-5')
      # puts ast.inspect

      ast = parser.parse('2+5')
      puts ast.inspect
      ast = parser.parse('2+5+10')
      puts ast.inspect
      ast = parser.parse('2*5')
      puts ast.inspect
      ast = parser.parse('2*5+10')
      puts ast.inspect
      ast = parser.parse('2*5+10+8')
      puts ast.inspect
      ast = parser.parse('2*5*2+10+8')
      puts ast.inspect
      ast = parser.parse('2+4*10')
      puts ast.inspect
      ast = parser.parse('2*5*5')
      puts ast.inspect
      ast = parser.parse('1+3+4+1+30*50*2+10+4+5')
      puts ast
      ast = parser.parse('2+5+3+4*4')
      puts ast.inspect


      # ast[:+][:left].should be_a Hash
      # ast[:+][:right].to_i should == 10
      # ast[:+][:right][:*].should_not nil
      # ast[:+][:right][:*][:left].to_i.should == 2
      # ast[:+][:right][:*][:right].to_i.should == 5
    end


  end

    # it "should recognize subtract operations" do
    #   ast = parser.parse('2-5')
    #   ast[:-][:left].to_i.should == 2
    #   ast[:-][:right].to_i.should == 5
    # end

    # it "should recognize a valid expression with blank spaces like '  4   +   3  '" do
    #   lambda{ parser.parse("  4   +  3  ") }.should_not raise_error
    # end

    # it "should raise error a incomplet expression like '1 +'" do
    #   lambda{ parser.parse("1 +") }.should raise_error(Parslet::ParseFailed)
    # end

  # context "For complex expression like '2 + 5 - 3' (sill without functions)" do
  #   it "should recognize '2 + 5 - 3' as a valid expression" do
  #     ast = parser.parse("2 + 5 -3")
  #     ast[:left].to_i.should == 2
  #     ast[:operator].to_s.should == '+'
  #     ast[:right].should be_a Hash
  #     ast[:right][:left].to_i.should == 5
  #     ast[:right][:operator].should == '-'
  #     ast[:right][:right].to_i.should == 3
  #   end

  #   it "should recognize '12 + 15 - 3 * 4 / 2' as a valid expression" do
  #     ast = parser.parse("12 + 15 -3 * 4/2")
  #     ast[:left].to_i.should == 12
  #     ast[:operator].to_s.should == '+'
  #     ast[:right].should be_a Hash
  #     ast[:right][:left].to_i.should == 15
  #     ast[:right][:operator].should == '-'
  #     ast[:right][:right].should be_a Hash
  #     ast[:right][:right][:left].to_i.should == 3
  #     ast[:right][:right][:operator].should == '*'
  #     ast[:right][:right][:right].should be_a Hash
  #     ast[:right][:right][:right][:left].to_i.should == 4
  #     ast[:right][:right][:right][:operator].should == '/'
  #     ast[:right][:right][:right][:right].to_i.should == 2
  #   end

  #   it "should raise error a incomplet expression like '1 + 5 *" do
  #     lambda{ parser.parse("1 + 5 *") }.should raise_error(Parslet::ParseFailed)
  #   end

  # end

end