# encoding: utf-8

module Assembla
  class Client::Issues::Assignees < API
    # Lists all the available assignees (owner + collaborators)
    # to which issues may be assigned.
    #
    # @example
    #  Assembla.issues.assignees.list 'owner', 'repo'
    #  Assembla.issues.assignees.list 'owner', 'repo' { |assignee| ... }
    #
    # @api public
    def list(*args)
      arguments(args, required: [:owner, :repo])

      response = get_request("/repos/#{arguments.owner}/#{arguments.repo}/assignees", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end
    alias :all :list

    # Check to see if a particular user is an assignee for a repository.
    #
    # @example
    #  Assembla.issues.assignees.check 'user', 'repo', 'assignee'
    #
    # @example
    #  assembla = Assembla.new user: 'user-name', repo: 'repo-name'
    #  assembla.issues.assignees.check 'assignee'
    #
    # @api public
    def check(*args)
      arguments(args, required: [:owner, :repo, :assignee])
      params = arguments.params

      get_request("/repos/#{arguments.owner}/#{arguments.repo}/assignees/#{arguments.assignee}",params)
      true
    rescue Assembla::Error::NotFound
      false
    end
  end # Issues::Assignees
end # Assembla
