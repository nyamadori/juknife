# frozen_string_literal: true

require 'faraday'
require 'nokogiri'

module Juknife
  # :nodoc:
  module Middleware
    # A Fraday middleware to parse body string to Nokogiri document.
    class HTMLParser < Faraday::Response::Middleware
      def parse(body)
        Nokogiri.parse(body)
      end
    end
  end
end
