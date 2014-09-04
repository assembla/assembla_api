# encoding: utf-8

require 'multi_json'

module Assembla
  module Jsonable
    extend self

    def decode(*args)
      return unless args.first
      if MultiJson.respond_to?(:load)
        MultiJson.load *args
      else
        MultiJson.decode *args
      end
    end
  end
end
