# frozen_string_literal: true

module Juknife
  module Scraping
    module DSL
      class Items
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
          children_result = {}

          children.each do |child|
            child.visit(Context.new(selector, children_result))
          end

          context.result[name] = children_result
        end
      end
    end
  end
end
