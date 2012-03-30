#encoding: utf-8
module FormulaDSL
  module Functions

    MONTH = Proc.new{|args| "this.#{args.first}.getMonth() + 1" }
    YEAR  = Proc.new{|args| "this.#{args.first}.getYear()" }

  end
end
