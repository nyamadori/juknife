# frozen_string_literal: true

require 'faraday_middleware'

module Juknife
  # The agent to execute request and scraping to web page.
  class Agent
    def scrape(params = {})
      response(params).body
    end

    def response(params)
      connection(params).get
    end

    def connection(params)
      @connection ||= Faraday.new do |b|
        # request middlewares
        b.use Middleware::RequestDSL, params, &self.class.request_dsl
        b.use Faraday::Request::UrlEncoded

        # response middlewares
        b.use Middleware::ScrapingDSL, params, &self.class.scraping_dsl
        b.use Middleware::HTMLParser
        b.use Middleware::HTTPErrorHandler
        b.use FaradayMiddleware::FollowRedirects

        b.adapter :net_http
      end
    end

    class << self
      attr_reader :request_dsl, :scraping_dsl

      def request(&block)
        @request_dsl = block
      end

      def scraping(&block)
        @scraping_dsl = block
      end
    end
  end
end
