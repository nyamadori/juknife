# frozen_string_literal: true

require 'nokogiri'

module Juknife
  module Scraping
    # Juknife::Scraping::Runner object is a runner for scraping DSL.
    class Runner
      include DSL
      attr_reader :source, :block, :params

      def initialize(&block)
        @block = block
        instance_eval(&@block)
      end

      def run(source, params = {})
        @params = params
        @source = source
        result
      end

      def document
        @document ||= Nokogiri.parse(source)
      end

      def result
        context = Scraping::Context.new(document)

        children.each do |child|
          child.visit(context)
        end

        context.result
      end
    end
  end
end
