module Assembla
  class Client::Spaces::Tickets < API
    require_all 'assembla_api/client/spaces/tickets',
      'custom_fields'
      'statuses'

    # Access to Spaces::Tickets::Statuses API
    namespace :statuses
    namespace :custom_fields

    VALID_PARAMS_NAMES = %w[
      summary
      description
      priority
      component_id
      created_on
      permission_type
      is_story
      milestone_id
      tags
      followers
      notification_list
      status
      story_importance
      working_hours
      estimate
      assigned_to_id
      custom_fields
      hierarchy_type
      is_support
    ].freeze

    # @example
    # api.spaces.tickets.create 'project1', ticket: { summary: 'First ticket' }
    def create(*args)
      arguments(args, required: [:space]) do
        permit VALID_PARAMS_NAMES, recursive: true
        assert_required %w[ summary ]
        # TODO assert_values VALID_REQUEST_PARAM_VALUES
      end

      post_request("/spaces/#{arguments.space}/tickets", arguments.params)
    end

    # @example
    # api.spaces.tickets.get 'project1', 7
    def get(*args)
      arguments(args, required: [:space, :number])
      get_request("/spaces/#{arguments.space}/tickets/#{arguments.number}", arguments.params)
    end

    # @example
    # api.spaces.tickets.get_by_id 'project1', 1710
    def get_by_id(*args)
      arguments(args, required: [:space, :ticket_id])
      get_request("/spaces/#{arguments.space}/tickets/id/#{arguments.ticket_id}", arguments.params)
    end

    # @example
    # api.spaces.tickets.edit 'project1', 7, ticket: {description: 'REQ changed...'}
    def edit(*args)
      arguments(args, required: [:space, :number]) do
        permit VALID_PARAMS_NAMES , recursive: true
        # TODO assert_values VALID_REQUEST_PARAM_VALUES
      end

      put_request("/spaces/#{arguments.space}/tickets/#{arguments.number}", arguments.params)
    end

    # Delete ticket by number
    # @example
    # api.spaces.tickets.delete 'project1', 7
    def delete(*args)
      arguments(args, required: [:space, :number])
      delete_request("/spaces/#{arguments.space}/tickets/#{arguments.number}", arguments.params)
    end

    # @example
    # api.spaces.tickets.list 'project1'
    def list(*args)
      arguments(args, required: [:space])
      response = get_request("/spaces/#{arguments.space}/tickets", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end

    # @example
    # api.spaces.tickets.my 'project1'
    def my(*args)
      arguments(args, required: [:space])
      response = get_request("/spaces/#{arguments.space}/tickets/my_active", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end

    # @example
    # api.spaces.tickets.followed 'project1'
    def followed(*args)
      arguments(args, required: [:space])
      response = get_request("/spaces/#{arguments.space}/tickets/my_followed", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end

    # @example
    # api.spaces.tickets.by_milestone_id 'project1', 49
    def by_milestone_id(*args)
      arguments(args, required: [:space, :milestone_id])
      response = get_request("/spaces/#{arguments.space}/tickets/milestone/#{arguments.milestone_id}", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end

    # @example
    # api.spaces.tickets.by_milestone_id 'project1'
    def without_milestone(*args)
      arguments(args, required: [:space])
      response = get_request("/spaces/#{arguments.space}/tickets/no_milestone", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end

    # @example
    # api.spaces.tickets.attachments 'project1', 14
    def attachments(*args)
      arguments(args, required: [:space, :number])
      response = get_request("/spaces/#{arguments.space}/tickets/#{arguments.number}/attachments", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end

    # @example
    # api.spaces.tickets.tags 'project1', 14
    def tags(*args)
      arguments(args, required: [:space, :number])
      response = get_request("/spaces/#{arguments.space}/tickets/#{arguments.number}/tags", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end

    # @example
    # api.spaces.tickets.custom_reports 'project1'
    def custom_reports(*args)
      arguments(args, required: [:space])
      response = get_request("/spaces/#{arguments.space}/tickets/custom_reports", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end
  end # Tickets
end
