# frozen_string_literal: true

module Juknife
  # :nodoc:
  module Middleware
    autoload :HTMLParser, 'juknife/middleware/html_parser'
    autoload :HTTPErrorHandler, 'juknife/middleware/http_error_handler'
    autoload :RequestDSL, 'juknife/middleware/request_dsl'
    autoload :ScrapingDSL, 'juknife/middleware/scraping_dsl'
  end
end
