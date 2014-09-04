# encoding: utf-8

module Assembla
  module Error
    # Raised when Assembla returns the HTTP status code 400
    class BadRequest < ServiceError
      http_status_code 400

      def initialize(response)
        super(response)
      end
    end
  end
end # Assembla
