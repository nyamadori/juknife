# frozen_string_literal: true

require 'juknife/version'

# The module that contains everything Juknife-related.
module Juknife
  autoload :Request, 'juknife/request'
  autoload :Scraper, 'juknife/scraper'
  autoload :Scraping, 'juknife/scraping'
end
