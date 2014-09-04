# encoding: utf-8

require 'assembla_api/response'
require 'assembla_api/response/mashify'
require 'assembla_api/response/jsonize'
require 'assembla_api/response/raise_error'
require 'assembla_api/response/header'

module Assembla
  class Middleware
    def self.default(options = {})
      api = options[:api]
      proc do |builder|
        builder.use Assembla::Request::Jsonize
        builder.use Faraday::Request::Multipart
        builder.use Faraday::Request::UrlEncoded
        builder.use Assembla::Request::OAuth2, api.oauth_token if api.oauth_token?
        builder.use Assembla::Request::BasicAuth, api.authentication if api.basic_authed?

        builder.use Faraday::Response::Logger if ENV['DEBUG']
        unless options[:raw]
          builder.use Assembla::Response::Mashify
          builder.use Assembla::Response::Jsonize
        end
        builder.use Assembla::Response::RaiseError
        builder.adapter options[:adapter]
      end
    end
  end # Middleware
end # Assembla
