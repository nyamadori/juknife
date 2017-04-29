# frozen_string_literal: true

require 'juknife/version'

# The module that contains everything Juknife-related.
module Juknife
  autoload :DSL, './lib/juknife/dsl'
  autoload :Context, './lib/juknife/context'
  autoload :Knife, './lib/juknife/knife'
end
