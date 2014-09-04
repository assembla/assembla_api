# encoding: utf-8

module Assembla
  class Client::Users < API
    # Load all the modules after initializing Repos to avoid superclass mismatch
    require_all 'assembla_api/client/users',
      'emails',
      'followers',
      'keys'

    VALID_USER_PARAMS_NAMES = %w[
      name
      email
      blog
      company
      location
      hireable
      bio
    ].freeze

    # Access to Users::Emails API
    namespace :emails

    # Access to Users::Followers API
    namespace :followers

    # Access to Users::Keys API
    namespace :keys

    # List all users.
    #
    # This provides a dump of every user, in the order that they signed up
    # for Assembla.
    #
    # @param [Hash] params
    # @option [Integer] :since
    #   The integer ID of the last User that you’ve seen.
    #
    # @example
    #  users = Assembla::Users.new
    #  users.list
    #
    # @api public
    def list(*args)
      arguments(args)

      response = get_request("/users", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end
    alias :all :list

    # Get a single unauthenticated user
    #
    # @example
    #  assembla = Assembla.new
    #  assembla.users.get user: 'user-name'
    #
    # Get the authenticated user
    #
    # @example
    #  assembla = Assembla.new oauth_token: '...'
    #  assembla.users.get
    #
    # @api public
    def get(*args)
      params = arguments(args).params

      if user_name = params.delete('user')
        get_request("/users/#{user_name}", params)
      else
        get_request("/user", params)
      end
    end
    alias :find :get

    # Update the authenticated user
    #
    # @param [Hash] params
    # @option params [String] :name
    #   Optional string
    # @option params [String] :email
    #   Optional string - publically visible email address
    # @option params [String] :blog
    #   Optional string
    # @option params [String] :company
    #   Optional string
    # @option params [String] :location
    #   Optional string
    # @option params [String] :hireable
    #   Optional boolean
    # @option params [String] :bio
    #   Optional string
    #
    # @example
    #  assembla = Assembla.new oauth_token: '..'
    #  assembla.users.update
    #    name: "monalisa buildbot",
    #    email: "buildbot@assembla.com",
    #    blog: "https://assembla.com/blog",
    #    company: "Assembla",
    #    location: "San Francisco",
    #    hireable: true,
    #    bio: "There once..."
    #
    # @api public
    def update(*args)
      arguments(args) do
        permit VALID_USER_PARAMS_NAMES
      end

      patch_request("/user", arguments.params)
    end
  end # Users
end # Assembla
