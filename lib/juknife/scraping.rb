# frozen_string_literal: true

module Juknife
  # :nodoc:
  module Scraping
    extend ActiveSupport::Autoload

    autoload :DSL
    autoload :Context
    autoload :Runner
  end
end
