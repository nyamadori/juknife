# frozen_string_literal: true

require 'faraday'

module Juknife
  # :nodoc:
  module Middleware
    # A Faraday middleware to interpret Juknife request DSL
    class RequestDSL < Faraday::Middleware
      include Juknife::Request::DSL

      attr_reader :params

      def initialize(app, params = {}, &block)
        super(app)
        @params = params
        instance_eval(&block)
      end

      def call(env) # rubocop: disable Metrics/AbcSize
        uri = URI.parse(url_builder.call)
        uri.query = query_builder&.call&.to_query

        env[:url] = uri
        env[:method] = http_method
        env[:body] = body_builder&.call
        env[:request_headers] ||= {}

        if user_agent_builder
          env[:request_headers]['User-Agent'] = user_agent_builder&.call
        end

        @app.call(env)
      end
    end
  end
end
