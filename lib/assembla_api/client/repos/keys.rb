# encoding: utf-8

module Assembla
  class Client::Repos::Keys < API

    VALID_KEY_OPTIONS = %w[ title key ].freeze

    # List deploy keys
    #
    # @example
    #   assembla = Assembla.new
    #   assembla.repos.keys.list 'user-name', 'repo-name'
    #   assembla.repos.keys.list 'user-name', 'repo-name' { |key| ... }
    #
    # @example
    #   keys = Assembla::Repos::Keys.new user: 'user-name', repo: 'repo-name'
    #   keys.list
    #
    # @api public
    def list(*args)
      arguments(args, required: [:user, :repo])

      response = get_request("/repos/#{arguments.user}/#{arguments.repo}/keys", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end
    alias :all :list

    # Get a key
    #
    # @example
    #   assembla = Assembla.new
    #   assembla.repos.keys.get 'user-name', 'repo-name', 'key-id'
    #
    # @api public
    def get(*args)
      arguments(args, :required => [:user, :repo, :id])

      get_request("/repos/#{arguments.user}/#{arguments.repo}/keys/#{arguments.id}", arguments.params)
    end
    alias :find :get

    # Create a key
    #
    # @param [Hash] params
    # @option params [String] :title
    #   Required string.
    # @option params [String] :key
    #   Required string.
    #
    # @example
    #   assembla = Assembla.new
    #   assembla.repos.keys.create 'user-name', 'repo-name',
    #     title: "buildbot@octomac",
    #     key:  "ssh-rsa AAA..."
    #
    # @api public
    def create(*args)
      arguments(args, required: [:user, :repo]) do
        permit VALID_KEY_OPTIONS
        assert_required VALID_KEY_OPTIONS
      end

      post_request("/repos/#{arguments.user}/#{arguments.repo}/keys", arguments.params)
    end

    # Delete key
    #
    # @example
    #   assembla = Assembla.new
    #   assembla.repos.keys.delete 'user-name', 'repo-name', 'key-id'
    #
    # @api public
    def delete(*args)
      arguments(args, required: [:user, :repo, :id])
      params = arguments.params

      delete_request("/repos/#{arguments.user}/#{arguments.repo}/keys/#{arguments.id}", params)
    end
  end # Client::Repos::Keys
end # Assembla
