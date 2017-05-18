# frozen_string_literal: true

require 'juknife/version'
require 'active_support/dependencies/autoload'

# The module that contains everything Juknife-related.
module Juknife
  extend ActiveSupport::Autoload

  autoload :Agent
  autoload :Error
  autoload :Middleware
  autoload :Request
  autoload :Scraping
end
