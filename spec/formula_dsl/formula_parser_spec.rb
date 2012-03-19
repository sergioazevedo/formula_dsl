#encoding: utf-8
require 'spec_helper'

describe FormulaParser do

  let(:parser){ subject }

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

    it "should recognize a valid expression with blank spaces like '  4 +   3  '" do
      lambda{ parser.parse("  4 +  3  ") }.should_not raise_error
    end
  end

end