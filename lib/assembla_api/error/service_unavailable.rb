# encoding: utf-8

module Assembla #:nodoc
  # Raised when Assembla returns the HTTP status code 503
  module Error
    class ServiceUnavailable < ServiceError
      http_status_code 503

      def initialize(response)
        super(response)
      end

    end # ServiceUnavailable
  end # Error
end # Assembla
