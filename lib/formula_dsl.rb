require "rubygems"
require "bundler/setup"

Bundler.require(:default)

require 'parslet'
require 'formula_dsl/formula_parser'
require 'formula_dsl/ast_resolver'
require 'formula_dsl/expression'