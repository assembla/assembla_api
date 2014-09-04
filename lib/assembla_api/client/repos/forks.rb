# encoding: utf-8

module Assembla
  class Client::Repos::Forks < API
    # List repository forks
    #
    # @param [Hash] params
    # @input params [String] :sort
    #   The sort order. Can be either newest, oldest, or stargazers.
    #   Default: newest
    #
    # @example
    #   assembla = Assembla.new
    #   assembla.repos.forks.list 'user-name', 'repo-name'
    #   assembla.repos.forks.list 'user-name', 'repo-name' { |fork| ... }
    #
    # @api public
    def list(*args)
      arguments(args, required: [:user, :repo])

      response = get_request("/repos/#{arguments.user}/#{arguments.repo}/forks", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end
    alias :all :list

    # Create a fork for the authenticated user
    #
    # @param [Hash] params
    # @input params [String] :organization
    #   The organization login. The repository will be forked into
    #   this organization.
    #
    # @example
    #   assembla = Assembla.new
    #   assembla.repos.forks.create 'user-name', 'repo-name',
    #     organization: "assembla"
    #
    # @api public
    def create(*args)
      arguments(args, required: [:user, :repo])

      post_request("/repos/#{arguments.user}/#{arguments.repo}/forks", arguments.params)
    end
  end # Client::Repos::Forks
end # Assembla
