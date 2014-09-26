module Assembla
  class Client::Spaces::Tags < API

    VALID_PARAMS_NAMES = %w[
      name
      state
    ].freeze

    VALID_REQUEST_PARAM_VALUES = {
      'state' => [ 1, 2, 4 ]
    }

    # @example
    # api.spaces.tags.create 'project1', tag: { name: 'Backend' }
    def create(*args)
      arguments(args, required: [:space]) do
        permit VALID_PARAMS_NAMES, recursive: true
        assert_required %w[ name ]
        assert_values VALID_REQUEST_PARAM_VALUES
      end

      post_request("/spaces/#{arguments.space}/tags", arguments.params)
    end

    # @example
    # api.spaces.tags.get 'project1', 'tag-id'
    def get(*args)
      arguments(args, required: [:space, :id])
      get_request("/spaces/#{arguments.space}/tags/#{arguments.id}", arguments.params)
    end

    # @example
    # api.spaces.tags.edit 'project1', 'tag-id', tag: { state: 4 }
    def edit(*args)
      arguments(args, required: [:space, :id]) do
        permit VALID_PARAMS_NAMES , recursive: true
        assert_values VALID_REQUEST_PARAM_VALUES
      end

      put_request("/spaces/#{arguments.space}/tags/#{arguments.id}", arguments.params)
    end

    # Delete tag by ID
    # @example
    # api.spaces.tags.delete 'project1', 'tag-id'
    def delete(*args)
      arguments(args, required: [:space, :id])
      delete_request("/spaces/#{arguments.space}/tags/#{arguments.id}", arguments.params)
    end

    # @example
    # api.spaces.tags.list 'project1'
    def list(*args)
      arguments(args, required: [:space])
      response = get_request("/spaces/#{arguments.space}/tags", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end

    # @example
    # api.spaces.tags.active 'project1'
    def active(*args)
      arguments(args, required: [:space])
      response = get_request("/spaces/#{arguments.space}/tags/active", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end

    # @example
    # api.spaces.tags.proposed 'project1'
    def proposed(*args)
      arguments(args, required: [:space])
      response = get_request("/spaces/#{arguments.space}/tags/proposed", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end

    # @example
    # api.spaces.tags.hidden 'project1'
    def hidden(*args)
      arguments(args, required: [:space])
      response = get_request("/spaces/#{arguments.space}/tags/hidden", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end

    # @example
    # api.spaces.tags.tickets 'project1', 'tag-id'
    def tickets(*args)
      arguments(args, required: [:space, :id])
      response = get_request("/spaces/#{arguments.space}/tags/#{arguments.id}/tickets", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end
  end # tags
end
