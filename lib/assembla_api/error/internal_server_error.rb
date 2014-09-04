# encoding: utf-8

module Assembla #:nodoc
  # Raised when Assembla returns the HTTP status code 500
  module Error
    class InternalServerError < ServiceError
      http_status_code 500

      def initialize(response)
        super(response)
      end

    end # InternalServerError
  end # Error
end # Assembla
