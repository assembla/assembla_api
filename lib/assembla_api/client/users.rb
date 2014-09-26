# encoding: utf-8

module Assembla
  class Client::Users < API
    # Load all the modules after initializing Repos to avoid superclass mismatch
    require_all 'assembla_api/client/users',
      'keys'

    VALID_USER_PARAMS_NAMES = %w[
    ].freeze

    # Access to Users::Keys API
    namespace :keys

    # Get a single user
    #
    # @example
    #  assembla = Assembla.new oauth_token: '...'
    #  assembla.users.get user: 'user-name'
    #
    # Get the authenticated user
    #
    # @example
    #  assembla = Assembla.new oauth_token: '...'
    #  assembla.users.me
    #
    # @api public
    def get(*args)
      params = arguments(args).params

      if user_name = params.delete('user')
        get_request("/users/#{user_name}", params)
      else
        get_request("/user")
      end
    end

    alias :find :get
    alias :me :get

    # @example
    #  api.users.picture 'mike'
    def picture(*args)
      arguments(args, required: [ :user ])
      arguments.params['raw'] = true
      get_request("/users/#{arguments.user}/picture", arguments.params)
    end
  end # Users
end # Assembla
