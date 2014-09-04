# encoding: utf-8

module Assembla #:nodoc
  # Raised when invalid options are passed to a request body
  module Error
    class InvalidOptions < ClientError
      def initialize(invalid, valid)
        super(
          generate_message(
            :problem => "Invalid option #{invalid.keys.join(', ')} provided for this request.", 
            :summary => "Assembla gem checks the request parameters passed to ensure that assembla api is not hit unnecessairly and to fail fast.",
            :resolution => "Valid options are: #{valid.join(', ')}, make sure these are the ones you are using"
          )
        )
      end
    end
  end # Error
end # Assembla
