# frozen_string_literal: true

module Juknife
  module Scraping
    module DSL
      # A DSL node in the tree that makes an scope of element.
      class Scope
        include DSL

        attr_reader :selector, :args

        def initialize(selector, *args, &block)
          @selector = selector
          @args = args

          return unless block
          instance_eval(&block)
        end

        def visit(context)
          scope = context.find(selector)

          children.each do |child|
            child.visit(Context.new(scope, context.result))
          end
        end
      end
    end
  end
end
