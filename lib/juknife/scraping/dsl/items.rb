# frozen_string_literal: true

require 'active_support'
require 'active_support/core_ext/object'

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
          result = []

          context.find_all(selector).each do |ele_chlid|
            child_context = Context.new(ele_chlid, {})

            children.each do |child|
              child.visit(child_context)
            end

            result << child_context.result
          end

          context.result[name] =
            result.reject { |hash| hash.values.compact.all?(&:empty?) }
        end
      end
    end
  end
end
