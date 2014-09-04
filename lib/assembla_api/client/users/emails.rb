# encoding: utf-8
require 'cgi'

module Assembla
  class Client::Users::Emails < API

    # List email addresses for the authenticated user
    #
    # @example
    #  assembla = Assembla.new oauth_token: '...'
    #  assembla.users.emails.list
    #  assembla.users.emails.list { |email| ... }
    #
    # @return [Hash]
    #
    # @api public
    def list(*args)
      arguments(args)
      response = get_request("/user/emails", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end
    alias :all :list

    # Add email address(es) for the authenticated user
    #
    # @param [Array[String]] emails
    #   You can include a single email address or an array of addresses
    #
    # @example
    #  assembla = Assembla.new oauth_token: '...'
    #  assembla.users.emails.add "buildbot@assembla.com", "support@assembla.com"
    #
    # @api public
    def add(*args)
      arguments(args)
      params = arguments.params
      params['data'] = arguments.remaining unless arguments.remaining.empty?

      post_request("/user/emails", params)
    end
    alias :<< :add

    # Delete email address(es) for the authenticated user
    #
    # @param [Array[String]] emails
    #   You can include a single email address or an array of addresses
    #
    # @example
    #  assembla = Assembla.new oauth_token: '...'
    #  assembla.users.emails.delete "buildbot@assembla.com", "support@assembla.com"
    #
    # @api public
    def delete(*args)
      arguments(args)
      params = arguments.params
      params['data'] = arguments.remaining unless arguments.remaining.empty?

      delete_request("/user/emails", params)
    end
  end # Users::Emails
end # Assembla
