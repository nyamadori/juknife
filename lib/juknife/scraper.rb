# frozen_string_literal: true

module Juknife
  class Scraper
    def initialize
      @scraping = Scraping::Runner.new(&self.class.scraping_block)
      @request = Request::Runner.new(&self.class.request_block)
    end

    def scrape(params = {})
      source = @request.run(params)
      @scraping.run(source, params)
    end

    class << self
      attr_reader :scraping_block, :request_block

      def scraping(&block)
        @scraping_block = block
      end

      def request(&block)
        @request_block = block
      end
    end
  end
end
