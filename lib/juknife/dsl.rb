# frozen_string_literal: true

module Juknife
  # The DSL (Domain Specific Language) to scrape from web pages and
  # to populate the scraping results into a Hash object.
  module DSL
    # Define a scraping target in the page that has single content.
    #
    # @param name [String]  name to populate into some destinations
    # @param selector [String] CSS selector to search an element
    # @yield [text] give a text of found element to process the text before
    #               populating
    def item(name, selector, &block)
      node = current_node.at_css(selector)
      write_item(name, node, &block)
    end

    # Define a scraping target in the page that has multiple content.
    #
    # @param name [String]  name to populate into some destinations
    # @param selector [String] CSS selector to search an element
    # @yield [text] give a text of found element to process the text before
    #               populating
    def items(name, selector, &block)
      nodes = current_node.css(selector)
      result_items = []

      nodes.each do |node|
        context = Context.new(owner, node, {})
        owner.instance_exec(context, &block)
        result_items << context.result
      end

      write_items(name, result_items)
    end

    private

    def write_item(name, node, &block)
      value = node ? normalize_text(node.text) : nil
      result[name] = block ? yield(node) : value
    end

    def write_items(name, items)
      result[name] = items.reject { |item| item.all?(&:empty?) }
    end

    def normalize_text(text)
      text.strip.gsub(/(\s)(\s)*/, '\1')
    end
  end
end
