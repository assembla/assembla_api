# encoding: utf-8

module Assembla #:nodoc
  # Raised when Assembla returns the HTTP status code 404
  module Error
    class NotFound < ServiceError
      http_status_code 404

      def initialize(env)
        super(env)
      end
    end
  end # Error
end # Assembla
