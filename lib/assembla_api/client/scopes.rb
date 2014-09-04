# encoding: utf-8

module Assembla
  class Client::Scopes < API
    # Check what OAuth scopes you have.
    #
    # = Examples
    #  assembla = Assembla.new :oauth_token => 'token'
    #  assembla.scopes.all
    #
    def list(*args)
      arguments(args)
      response = get_request("/user", arguments.params)
      response.headers.oauth_scopes ? response.headers.oauth_scopes.split(',') : response
    end
    alias :all :list
  end
end # Assembla
