#encoding: utf-8

module FormulaDSL
  module FunctionExpressionFactory

    def self.new(function_name)
      function = constantize("FormulaDSL::Functions::#{function_name.upcase}")

      function
    end

    private
      def self.constantize( string )
        module_names = string.split('::')
        constant = Module.const_get( module_names.first.to_sym )

        module_names = module_names.drop(1)
        module_names.each{ |name| constant = constant.const_get( name.to_sym ) }

        constant
      end

  end
end