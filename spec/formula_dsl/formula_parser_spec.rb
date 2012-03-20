#encoding: utf-8
require 'spec_helper'

describe FormulaParser do

  let(:parser){ subject }
  it "should recognize multiply operations" do
    ast = parser.parse('2*5')
    puts ast.inspect
    ast[:left].to_i.should == 2
    ast[:operator].to_s.should == '*'
    ast[:right].to_i.should == 5
  end
  it "should recognize division operations" do
    ast = parser.parse('2/5')
    ast[:left].to_i.should == 2
    ast[:operator].to_s.should == '/'
    ast[:right].to_i.should == 5
  end
  it "should recognize sum operations" do
    ast = parser.parse('2+5')
    ast[:left].to_i.should == 2
    ast[:operator].to_s.should == '+'
    ast[:right].to_i.should == 5
  end
  it "should recognize subtract operations" do
    ast = parser.parse('2-5')
    ast[:left].to_i.should == 2
    ast[:operator].to_s.should == '-'
    ast[:right].to_i.should == 5

  end

  context "For single binary operations like '2 + 2' " do
    it "should recognize '1+1' as a valid expression" do
      lambda{ parser.parse("1+1") }.should_not raise_error
    end

    it "should raise error a incomplet expression like '1 +'" do
      lambda{ parser.parse("1 +") }.should raise_error(Parslet::ParseFailed)
    end

    it "should recognize a valid expression with blank spaces like 1 + 2" do
      lambda{ parser.parse("1 + 2") }.should_not raise_error
    end

    it "should recognize a valid expression with blank spaces like '  4   +   3  '" do
      lambda{ parser.parse("  4   +  3  ") }.should_not raise_error
    end
  end

  context "With a more complex expression like '2 + 5 - 3' " do
    it "should recognize '2 + 5 - 3' as a valid expression" do
      lambda{ parser.parse( "2 + 5 -3") }.should_not raise_error(Parslet::ParseFailed)
    end

    it "should raise error a incomplet expression like '1 + 5 *" do
      lambda{ parser.parse("1 + 5 *") }.should raise_error(Parslet::ParseFailed)
    end

  end

end