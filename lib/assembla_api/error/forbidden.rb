# encoding: utf-8

module Assembla #:nodoc
  # Raised when Assembla returns the HTTP status code 403
  module Error
    class Forbidden < ServiceError
      http_status_code 403

      def initialize(response)
        super(response)
      end
    end
  end # Error
end # Assembla
