# frozen_string_literal: true

require 'faraday'

module Juknife
  # :nodoc:
  module Middleware
    # A middleware to handle HTTP errors
    class HTTPErrorHandler < Faraday::Response::Middleware
      def on_complete(env)
        case env[:status]
        when 400..499
          raise HTTPClientError, env[:status]
        when 500..599
          raise HTTPServerError, env[:status]
        end
      end
    end
  end
end
