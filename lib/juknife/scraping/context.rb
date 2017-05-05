# frozen_string_literal: true

module Juknife
  module Scraping
    class Context
      attr_reader :node, :result

      def initialize(node, result = {})
        @node = node
        @result = result
      end
    end
  end
end
