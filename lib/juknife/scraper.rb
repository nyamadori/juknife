# frozen_string_literal: true

module Juknife
  class Scraper
    def scrape
      _scrape(self.class)
    end

    def _scrape(node)
      context = Scraping::Context.new('root')

      node.children&.each do |child|
        child.visit(context)
      end

      context
    end

    class << self
      include Scraping::DSL
      include Request::DSL
    end
  end
end
