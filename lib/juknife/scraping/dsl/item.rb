# frozen_string_literal: true

module Juknife
  module Scraping
    module DSL
      class Item
        include DSL

        attr_reader :name, :selector, :type

        def initialize(name, selector, type = :string, *args, &block)
          @name = name
          @selector = selector
          @type = type
          @args = args

          return unless block
          instance_eval(&block)
        end

        def visit(context)
          context.result[name] = context.text(selector)
        end
      end
    end
  end
end
