# encoding: utf-8

module Assembla
  class Client::Activity < API

    def list(*args)
      arguments(args)

      response = get_request("/activity", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end

  end # Activity
end # Assembla
