# encoding: utf-8

module Assembla
  class Client::Users::Keys < API

    VALID_KEY_PARAM_NAMES = %w[ title key ].freeze

    # List public keys for the authenticated user
    #
    # @example
    #  assembla = Assembla.new oauth_token: '...'
    #  assembla.users.keys.list
    #  assembla.users.keys.list { |key| ... }
    #
    # List public keys for the specified user
    #
    # @example
    #  assembla.users.keys.list user: 'user-name'
    #  assembla.users.keys.list user: 'user-name' { |key| ... }
    #
    # @return [Hash]
    #
    # @api public
    def list(*args)
      params = arguments(args).params
      response = if (user = params.delete('user'))
        get_request("/users/#{user}/keys", params)
      else
        get_request("/user/keys", params)
      end
      return response unless block_given?
      response.each { |el| yield el }
    end
    alias :all :list

    # Get a single pulic key for the authenticated user
    #
    # @example
    #  assembla = Assembla.new oauth_token: '...'
    #  assembla.users.keys.get 'key-id'
    #
    # @api public
    def get(*args)
      arguments(args, required: [:id])
      get_request("/user/keys/#{arguments.id}", arguments.params)
    end
    alias :find :get

    # Create a public key for the authenticated user
    #
    # @param [Hash] params
    # @option [String] :title
    #   Required string
    # @option [String] :key
    #   Required string. sha key
    #
    # @example
    #  assembla = Assembla.new oauth_token: '...'
    #  assembla.users.keys.create "title": "buildbot@octomac", "key": "ssh-rsa AAA..."
    #
    # @api public
    def create(*args)
      arguments(args) do
        permit VALID_KEY_PARAM_NAMES
      end
      post_request("/user/keys", arguments.params)
    end

    # Update a public key for the authenticated user
    #
    # @param [Hash] params
    # @option [String] :title
    #   Required string
    # @option [String] :key
    #   Required string. sha key
    #
    # @example
    #  assembla = Assembla.new oauth_token: '...'
    #  assembla.users.keys.update 'key-id', "title": "buildbot@octomac",
    #    "key": "ssh-rsa AAA..."
    #
    # @api public
    def update(*args)
      arguments(args, required: [:id]) do
        permit VALID_KEY_PARAM_NAMES
      end
      patch_request("/user/keys/#{arguments.id}", arguments.params)
    end

    # Delete a public key for the authenticated user
    #
    # @example
    #  assembla = Assembla.new oauth_token: '...'
    #  assembla.users.keys.delete 'key-id'
    #
    # @api public
    def delete(*args)
      arguments(args, required: [:id])
      delete_request("/user/keys/#{arguments.id}", arguments.params)
    end
  end # Users::Keys
end # Assembla
