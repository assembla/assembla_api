# encoding: utf-8

module Assembla
  class Client::Activity::Events < API

    # List all public events
    #
    # @example
    #  assembla = Assembla.new
    #  assembla.activity.events.public
    #  assembla.activity.events.public { |event| ... }
    #
    # @api public
    def public(*args)
      arguments(args)

      response = get_request("/events", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end
    alias :public_events :public
    alias :list_public :public
    alias :list_public_events :public

    # List all repository events for a given user
    #
    # @example
    #   assembla = Assembla.new
    #   assembla.activity.events.repository 'user-name', 'repo-name'
    #   assembla.activity.events.repository 'user-name', 'repo-name' { |event| ... }
    #
    # @example
    #   assembla.activity.events.repository user: 'user-name', repo: 'repo-name'
    #   assembla.activity.events.repository user: 'user-name', repo: 'repo-name' {|event| ... }
    #
    # @api public
    def repository(*args)
      arguments(args, required: [:user, :repo])

      response = get_request("/repos/#{arguments.user}/#{arguments.repo}/events", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end
    alias :repos :repository
    alias :repo_events :repository
    alias :repository_events :repository
    alias :list_repository_events :repository

    # List all issue events for a given repository
    #
    # @example
    #   assembla = Assembla.new
    #   assembla.activity.events.issue 'user-name', 'repo-name'
    #   assembla.activity.events.issue 'user-name', 'repo-name' { |event| ... }
    #
    # @example
    #   assembla.activity.events.issue user: 'user-name', repo: 'repo-name'
    #   assembla.activity.events.issue user: 'user-name', repo: 'repo-name' { |event| ... }
    #
    # @api public
    def issue(*args)
      arguments(args, required: [:user, :repo])

      response = get_request("/repos/#{arguments.user}/#{arguments.repo}/issues/events", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end
    alias :issues :issue
    alias :issue_events :issue
    alias :list_issue_events :issue

    # List all public events for a network of repositories
    #
    # @example
    #   assembla = Assembla.new
    #   assembla.activity.events.network 'user-name', 'repo-name'
    #   assembla.activity.events.network 'user-name', 'repo-name' { |event| ... }
    #
    # @example
    #   assembla.activity.events.network user: 'user-name', repo: 'repo-name'
    #   assembla.activity.events.network user: 'user-name', repo: 'repo-name' { |event| ... }
    #
    # @api public
    def network(*args)
      arguments(args, required: [:user, :repo])

      response = get_request("/networks/#{arguments.user}/#{arguments.repo}/events", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end
    alias :repo_network :network
    alias :repository_network :network
    alias :list_repo_network_events :network
    alias :list_repository_network_events :network

    # List all public events for an organization
    #
    # @example
    #   assembla = Assembla.new
    #   assembla.activity.events.org 'org-name'
    #   assembla.activity.events.org 'org-name' { |event| ... }
    #
    # @example
    #   assembla.activity.events.org name: 'org-name'
    #   assembla.activity.events.org name: 'org-name' { |event| ... }
    #
    # @api public
    def org(*args)
      arguments(args, required: [:name])

      response = get_request("/orgs/#{arguments.name}/events", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end
    alias :organization :org
    alias :list_orgs :org
    alias :list_org_events :org
    alias :list_organization_events :org

    # List all events that a user has received
    #
    # These are events that you’ve received by watching repos
    # and following users. If you are authenticated as the given user,
    # you will see private events. Otherwise, you’ll only see public events.
    #
    # @example
    #   assembla = Assembla.new
    #   assembla.activity.events.received 'user-name'
    #   assembla.activity.events.received 'user-name' { |event| ... }
    #
    # List all public events that a user has received
    #
    # @example
    #   assembla = Assembla.new
    #   assembla.activity.events.received 'user-name', public: true
    #   assembla.activity.events.received 'user-name', public: true { |event| ... }
    #
    # @api public
    def received(*args)
      arguments(args, required: [:user])
      params = arguments.params

      public_events = if params['public']
        params.delete('public')
        '/public'
      end

      response = get_request("/users/#{arguments.user}/received_events#{public_events}", params)
      return response unless block_given?
      response.each { |el| yield el }
    end
    alias :user_received :received
    alias :list_user_received :received

    # List all events that a user has performed
    #
    # If you are authenticated as the given user, you will see your private
    # events. Otherwise, you’ll only see public events.
    #
    # @example
    #   assembla = Assembla.new
    #   assembla.activity.events.performed 'user-name'
    #   assembla.activity.events.performed 'user-name' { |event| ... }
    #
    # List all public events that a user has performed
    #
    # @example
    #   assembla = Assembla.new
    #   assembla.activity.events.performed 'user-name', public: true
    #   assembla.activity.events.performed 'user-name', public: true { |event| ... }
    #
    # @api public
    def performed(*args)
      arguments(args, required: [:user])
      params = arguments.params

      public_events = if params['public']
        params.delete('public')
        '/public'
      end

      response = get_request("/users/#{arguments.user}/events#{public_events}", params)
      return response unless block_given?
      response.each { |el| yield el }
    end
    alias :user_performed :performed
    alias :list_user_performed :performed

    # List all events for an organization
    #
    # This is the user’s organization dashboard. You must be authenticated
    # as the user to view this.
    #
    # @example
    #   assembla = Assembla.new
    #   assembla.activity.events.user_org 'user-name', 'org-name'
    #   assembla.activity.events.user_org 'user-name', 'org-name' { |event| ... }
    #
    # @example
    #   assembla.activity.events.user_org user: 'user-name', name: 'org-name'
    #   assembla.activity.events.user_org user: 'user-name', name: 'org-name' {|event| ...}
    #
    # @api public
    def user_org(*args)
      arguments(args, required: [:user, :name])

      response = get_request("/users/#{arguments.user}/events/orgs/#{arguments.name}", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end
    alias :user_organization :user_org
    alias :list_user_org :user_org
    alias :list_user_org_events :user_org
    alias :list_user_organization_events :user_org
  end # Client::Activity::Events
end # Assembla
