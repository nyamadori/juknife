# frozen_string_literal: true

module Juknife
  module Request
    module DSL
      HTTP_METHODS = %i[get post put delete head patch options].freeze

      attr_reader :http_method, :url_builder, :body_builder

      HTTP_METHODS.each do |method|
        define_method(method) do |url, &block|
          @http_method = method
          @url_builder = block || proc { url }
        end
      end

      def body(&block)
        @body_builder = block
      end
    end
  end
end
