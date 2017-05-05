# frozen_string_literal: true

require_relative 'dsl/item'
require_relative 'dsl/items'
require_relative 'dsl/scope'

module Juknife
  module Scraping
    module DSL
      autoload :Item, 'juknife/scraping/dsl/item'
      autoload :Items, 'juknife/scraping/dsl/items'
      autoload :Scope, 'juknife/scraping/dsl/scope'

      def item(name, *args, &block)
        children << Item.new(name, *args, &block)
      end

      def items(name, *args, &block)
        children << Items.new(name, *args, &block)
      end

      def scope(name, *args, &block)
        children << Scope.new(name, *args, &block)
      end

      def children
        @children ||= []
      end
    end
  end
end
