# encoding: utf-8

require 'faraday'
require 'assembla_api/jsonable'

module Assembla
  class Response::Jsonize < Response
    include Assembla::Jsonable

    dependency 'multi_json'

    define_parser do |body|
      Assembla::Jsonable.decode body
    end

    def parse(body)
      case body
      when ''
        nil
      when 'true'
        true
      when 'false'
        false
      else
        self.class.parser.call body
      end
    end
  end # Response::Jsonize
end # Assembla
