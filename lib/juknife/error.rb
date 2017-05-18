# frozen_string_literal: true

module Juknife
  class Error < StandardError
  end

  class HTTPClientError < Error
  end

  class HTTPServerError < Error
  end
end
