# frozen_string_literal: true

module Juknife
  module Request
    module DSL
      attr_reader :url

      def url(url)
        @url = url
      end
    end
  end
end
