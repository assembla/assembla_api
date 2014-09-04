# encoding: utf-8

module Assembla #:nodoc
  # Raised when Assembla returns the HTTP status code 401
  module Error
    class Unauthorized < ServiceError
      http_status_code 401

      def initialize(response)
        super(response)
      end

    end # Unauthorized
  end # Error
end # Assembla
