# frozen_string_literal: true

module Juknife
  # The DSL (Domain Specific Language) to scrape from web pages and
  # to populate the scraping results into a Hash object.
  module DSL
    # Define a scraping target in the page that has single content.
    #
    # @param name [String]  name to populate into some destinations
    # @param xpath [String] xpath to search an element
    # @yield [text] give a text of found element to process the text before
    #               populating
    def item(name, xpath, &block)
      node = current_node.at_xpath(xpath)
      write_item(name, node, &block)
    end

    # Define a scraping target in the page that has multiple content.
    #
    # @param name [String]  name to populate into some destinations
    # @param xpath [String] xpath to search an element
    # @yield [text] give a text of found element to process the text before
    #               populating
    def items(name, xpath, &block)
      nodes = current_node.xpath(xpath)
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
