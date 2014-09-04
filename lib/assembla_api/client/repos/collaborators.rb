# encoding: utf-8

module Assembla
  class Client::Repos::Collaborators < API
    # List collaborators
    #
    # When authenticating as an organization owner of an
    # organization-owned repository, all organization owners are included
    # in the list of collaborators. Otherwise, only users with access to the
    # repository are returned in the collaborators list.
    #
    # @example
    #  assembla = Assembla.new
    #  assembla.repos.collaborators.list 'user-name', 'repo-name'
    #
    # @example
    #  assembla.repos.collaborators.list 'user-name', 'repo-name' { |cbr| .. }
    #
    # @return [Array]
    #
    # @api public
    def list(*args)
      arguments(args, required: [:user, :repo])
      params = arguments.params

      response = get_request("/repos/#{arguments.user}/#{arguments.repo}/collaborators", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end
    alias :all :list

    # Add collaborator
    #
    # @example
    #  assembla = Assembla.new
    #  assembla.collaborators.add 'user', 'repo', 'username'
    #
    # @example
    #  collaborators = Assembla::Repos::Collaborators.new
    #  collaborators.add 'user', 'repo', 'username'
    #
    # @api public
    def add(*args)
      arguments(args, required: [:user, :repo, :username])

      put_request("/repos/#{arguments.user}/#{arguments.repo}/collaborators/#{arguments.username}", arguments.params)
    end
    alias :<< :add

    # Checks if user is a collaborator for a given repository
    #
    # @example
    #  assembla = Assembla.new
    #  assembla.repos.collaborators.collaborator?('user', 'repo', 'username')
    #
    # @example
    #  assembla = Assembla.new user: 'user-name', repo: 'repo-name'
    #  assembla.collaborators.collaborator? username: 'collaborator'
    #
    # @api public
    def collaborator?(*args)
      arguments(args, required: [:user, :repo, :username])

      get_request("/repos/#{arguments.user}/#{arguments.repo}/collaborators/#{arguments.username}", arguments.params)
      true
    rescue Assembla::Error::NotFound
      false
    end

    # Removes collaborator
    #
    # @example
    #  assembla = Assembla.new
    #  assembla.repos.collaborators.remove 'user', 'repo', 'username'
    #
    # @api public
    def remove(*args)
      arguments(args, required: [:user, :repo, :username])

      delete_request("/repos/#{arguments.user}/#{arguments.repo}/collaborators/#{arguments.username}", arguments.params)
    end
  end # Client::Repos::Collaborators
end # Assembla
