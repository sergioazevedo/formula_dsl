#encoding: utf-8
require 'spec_helper'

module FormulaDSL
  describe Parser do

    let(:parser){ subject }

    context "Single Expression's" do

      it "should recognize a number '2' " do
        ast = parser.parse('2')
        ast.to_s.should == '2'
      end

      it "should recognize a string '\"abc\"' " do
        ast = parser.parse('"abc"')
        ast.to_s.should == %Q("abc")
      end

      it "should recognize expression '2 + 1' " do
        ast = parser.parse('2 + 1')
        ast.to_s.should == %Q({:+=>{:left=>"2"@0, :right=>"1"@4}})
      end

      it "should recognize expression '2 + 1 + 3' " do
        ast = parser.parse('2 + 1 + 3')
        ast.to_s.should == %Q({:+=>{:left=>{:+=>{:left=>"2"@0, :right=>"1"@4}}, :right=>"3"@8}})
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

    context "Expressions based on identifier names (aka variables)" do
      it "should recognize expression 'budget + fee' " do
        ast = parser.parse('budget + fee')
        ast.to_s.should == %Q({:+=>{:left=>"budget"@0, :right=>"fee"@9}})
      end

      it "should recognize expression 'budget - fee' " do
        ast = parser.parse('budget - fee')
        ast.to_s.should == %Q({:-=>{:left=>"budget"@0, :right=>"fee"@9}})
      end

      it "should recognize expression 'budget * fee' " do
        ast = parser.parse('budget * fee')
        ast.to_s.should == %Q({:*=>{:left=>"budget"@0, :right=>"fee"@9}})
      end

      it "should recognize expression 'budget + 1 + fee' " do
        ast = parser.parse('budget + 1 + fee')
        ast.to_s.should == %Q({:+=>{:left=>{:+=>{:left=>"budget"@0, :right=>"1"@9}}, :right=>"fee"@13}})
      end

      it "should recognize expression 'budget * 1 + fee' " do
        ast = parser.parse('budget * 1 + fee')
        ast.to_s.should == %Q({:+=>{:left=>{:*=>{:left=>"budget"@0, :right=>"1"@9}}, :right=>"fee"@13}})
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

      it " should recognize expression with 2 functions 'Month(data) + Year(data)'" do
        ast = parser.parse('Month(data) + Year(data)')
        ast.to_s.should == %Q({:+=>{:left=>{:function=>{:name=>"Month"@0, :args=>"data"@6}}, :right=>{:function=>{:name=>"Year"@14, :args=>"data"@19}}}})
      end
    end

    context "Expressions with string concatenation" do
      it " should recognize expression with string concat \"A\" + \"B\"'" do
        ast = parser.parse('"A" + "B"')
        ast.to_s.should == %Q({:+=>{:left=>"\\\"A\\\""@0, :right=>"\\\"B\\\""@6}})
      end

      it " should recognize expression with string concat '\"A\" + \"B\" + \"C\" ' " do
        ast = parser.parse('"A" + "B" + "C"')
        ast.to_s.should == %Q({:+=>{:left=>{:+=>{:left=>"\\\"A\\\""@0, :right=>"\\\"B\\\""@6}}, :right=>"\\\"C\\\""@12}})
      end

      it " should recognize expression with string concat 'Month(data) + \"/\"'" do
        ast = parser.parse('Month(data) + "/"')
        ast.to_s.should == %Q({:+=>{:left=>{:function=>{:name=>"Month"@0, :args=>"data"@6}}, :right=>"\\\"/\\\""@14}})
      end

      it " should recognize expression with string concat 'Month(data) + \"/\" + Year(data)'" do
        ast = parser.parse('Month(data) + "/" + Year(data)')
        ast.to_s.should == %Q({:+=>{:left=>{:function=>{:name=>"Month"@0, :args=>"data"@6}}, :right=>{:+=>{:left=>"\\\"/\\\""@14, :right=>{:function=>{:name=>"Year"@20, :args=>"data"@25}}}}}})
      end

      it " should recognize expression with string concat 'Month(data) - 1 + \"/\" + Year(data)'" do
        ast = parser.parse('Month(data) - 1 + "/" + Year(data)')
        ast.to_s.should == %Q({:-=>{:left=>{:function=>{:name=>\"Month\"@0, :args=>\"data\"@6}}, :right=>{:+=>{:left=>\"1\"@14, :right=>{:+=>{:left=>\"\\\"/\\\"\"@18, :right=>{:function=>{:name=>\"Year\"@24, :args=>\"data\"@29}}}}}}}})
      end

      it " should recognize expression with string concat 'Month(data) - 1 + \"/\" + Year(data)'" do
        ast = parser.parse('Month(data) * 1 + "/" + Year(data)')
        ast.to_s.should == %Q({:*=>{:left=>{:function=>{:name=>\"Month\"@0, :args=>\"data\"@6}}, :right=>{:+=>{:left=>\"1\"@14, :right=>{:+=>{:left=>\"\\\"/\\\"\"@18, :right=>{:function=>{:name=>\"Year\"@24, :args=>\"data\"@29}}}}}}}})
      end

      it " should recognize expression with string concat 'Month(data) - 1 + \"/\" + Year(data)'" do
        ast = parser.parse('Month(data) / 1 + "/" + Year(data)')
        ast.to_s.should == %Q({:/=>{:left=>{:function=>{:name=>\"Month\"@0, :args=>\"data\"@6}}, :right=>{:+=>{:left=>\"1\"@14, :right=>{:+=>{:left=>\"\\\"/\\\"\"@18, :right=>{:function=>{:name=>\"Year\"@24, :args=>\"data\"@29}}}}}}}})
      end

    end

  end
end