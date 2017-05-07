# frozen_string_literal: true

require 'faraday'

module Juknife
  module Request
    # Juknife::Request::Runner object is a runner for request DSL.
    class Runner
      include DSL
      attr_reader :block, :params

      def initialize(&block)
        @block = block
        instance_eval(&@block)
      end

      def run(params = {})
        @params = params
        source
      end

      def source
        @source ||= response.body
      end

      private

      def response
        @response ||= rack_builder.build_response(connection, request)
      end

      def connection
        @connection ||=
          Faraday.new(url_builder.call, params: query_builder.call)
      end

      def rack_builder
        @builder ||= Faraday::RackBuilder.new
      end

      def request
        @request ||= connection.build_request(http_method) do |req|
          req.headers['User-Agent'] = user_agent_builder&.call
          req.body = body_builder&.call
        end
      end
    end
  end
end
