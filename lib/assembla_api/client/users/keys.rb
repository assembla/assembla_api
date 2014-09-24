# encoding: utf-8

module Assembla
  class Client::Users::Keys < API

    VALID_KEY_PARAM_NAMES = %w[ title key read_only ].freeze
    VALID_REQUEST_PARAM_VALUES = {
      'read_only' => [ true, false ],
    }

    # List public keys for the authenticated user
    #
    # @example
    #  assembla = Assembla.new oauth_token: '...'
    #  assembla.users.keys.list
    #  assembla.users.keys.list { |key| ... }
    #
    # @return [Hash]
    #
    # @api public
    def list(*args)
      params = arguments(args).params
      response = get_request("/user/ssh_keys", params)
      return response unless block_given?
      response.each { |el| yield el }
    end
    alias :all :list

    # Get a single pulic key for the authenticated user
    #
    # @example
    #  assembla = Assembla.new oauth_token: '...'
    #  assembla.users.keys.get 571
    #
    # @api public
    def get(*args)
      arguments(args, required: [:id])
      get_request("/user/ssh_keys/#{arguments.id}", arguments.params)
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
    #  assembla.users.keys.create ssh_key: {title: "buildbot@mac", key: "ssh-rsa AAA..."}
    #
    # @api public
    def create(*args)
      arguments(args) do
        permit VALID_KEY_PARAM_NAMES, recursive: true
        assert_values VALID_REQUEST_PARAM_VALUES
      end
      post_request("/user/ssh_keys", arguments.params)
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
    #  assembla.users.keys.update 571, "title": "buildbot@mac",
    #    "key": "ssh-rsa AAA..."
    #
    # @api public
    def edit(*args)
      arguments(args, required: [:id]) do
        permit VALID_KEY_PARAM_NAMES, recursive: true
        assert_values VALID_REQUEST_PARAM_VALUES
      end
      put_request("/user/ssh_keys/#{arguments.id}", arguments.params)
    end

    # Delete a public key for the authenticated user
    #
    # @example
    #  assembla = Assembla.new oauth_token: '...'
    #  assembla.users.keys.delete 571
    #
    # @api public
    def delete(*args)
      arguments(args, required: [:id])
      delete_request("/user/ssh_keys/#{arguments.id}", arguments.params)
    end
  end # Users::Keys
end # Assembla
