# encoding: utf-8

require 'faraday'
require 'base64'

module Assembla
  class Request
    class KeyAuth < Faraday::Middleware
      dependency 'base64'

      def call(env)
        unless @api_key.to_s.empty?
          env[:request_headers].merge!('X-Api-Key' => @api_key,
              'X-Api-Secret' => @api_secret)
        end

        @app.call env
      end

      def initialize(app, *args)
        @app = app
        options = args.extract_options!

        if options.has_key? :api_key
          @api_key = options[:api_key]
          @api_secret = options[:api_secret]
        end
      end
    end # KeyAuth
  end # Request
end # Assembla
