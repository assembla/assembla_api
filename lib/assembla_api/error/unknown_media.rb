# encoding: utf-8

module Assembla #:nodoc
  # Raised when invalid options are passed to a request body
  module Error
    class UnknownMedia < ClientError
      def initialize(file)
        super(
          generate_message(
            :problem => "Unknown content type for: '#{file}' provided for this request.",
            :summary => "Assembla gem infers the content type of the resource by calling the mime-types gem type inference.",
            :resolution => "Please install mime-types gem to infer the resource content type."
          )
        )
      end
    end
  end # Error
end # Assembla
