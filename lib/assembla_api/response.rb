# encoding: utf-8

require 'faraday'

module Assembla
  # Contains methods and attributes that act on the response returned from the 
  # request
  class Response < Faraday::Response::Middleware
    CONTENT_TYPE = 'Content-Type'.freeze

    class << self
      attr_accessor :parser
    end

    def self.define_parser(&block)
      @parser = block
    end

    def response_type(env)
      env[:response_headers][CONTENT_TYPE].to_s
    end

    def parse_response?(env)
      env[:body].respond_to? :to_str
    end

  end # Response
end # Assembla
