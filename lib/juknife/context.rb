module Juknife
  # A context to keep running states of scraping on the DSL.
  class Context
    include DSL

    # @!attribute [r] owner
    # @return [Scraper] scraper to keep a context
    attr_reader :owner

    # @!attribute [r] current_node
    # @return [Nokogiri::XML::Element] current node
    attr_reader :current_node

    # @!attribute [r] result
    # @return [Hash] result of scraping from a web page
    attr_reader :result

    def initialize(owner, node, result)
      @owner = owner
      @current_node = node
      @result = result
    end
  end
end
