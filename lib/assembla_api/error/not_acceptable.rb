# encoding: utf-8

module Assembla #:nodoc
  # Raised when Assembla returns the HTTP status code 406
  module Error
    class NotAcceptable < ServiceError
      http_status_code 406

      def initialize(response)
        super(response)
      end

    end # NotAcceptable
  end # Error
end # Assembla
