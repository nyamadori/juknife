# frozen_string_literal: true

require 'faraday'

module Juknife
  # :nodoc:
  module Middleware
    # A Faraday middleware to interpret Juknife scraping DSL
    class ScrapingDSL < Faraday::Response::Middleware
      include Juknife::Scraping::DSL

      def initialize(app, params = {}, &block)
        super(app)
        @params = params
        instance_eval(&block)
      end

      def parse(doc)
        context = Juknife::Scraping::Context.new(doc)

        children.each do |child|
          child.visit(context)
        end

        context.result
      end
    end
  end
end
