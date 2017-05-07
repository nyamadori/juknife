# frozen_string_literal: true

module Juknife
  module Scraping
    class Context
      attr_reader :node, :result

      def initialize(node, result = {})
        @node = node
        @result = result
      end

      def find(selector)
        node.at_css(selector)
      end

      def find_all(selector)
        node.css(selector)
      end

      def text(selector)
        find(selector)&.text&.strip
      end
    end
  end
end
