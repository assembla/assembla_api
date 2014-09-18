module Assembla
  class Client::Spaces::Milestones < API

    VALID_PARAMS_NAMES = %w[
      title
      user_id
      is_completed
      release_level
      release_notes
      planner_type
    ].freeze

    VALID_REQUEST_PARAM_VALUES = {
      'release_level' => [ 1, 2, 3 ],   # Alpha, Beta, Stable
      'planner_type' => [ 0, 1, 2 ],    # None, Backlog, Current
      'is_completed' => [ true, false ],
    }

    # @example
    # api.spaces.milestones.create 'project1', milestone: { title: 'Mobile App V2' }
    def create(*args)
      arguments(args, required: [:space]) do
        permit VALID_PARAMS_NAMES, recursive: true
        assert_required %w[ title ]
        assert_values VALID_REQUEST_PARAM_VALUES
      end

      post_request("/spaces/#{arguments.space}/milestones", arguments.params)
    end

    # @example
    # api.spaces.milestones.get 'project1', 7
    def get(*args)
      arguments(args, required: [:space, :id])
      get_request("/spaces/#{arguments.space}/milestones/#{arguments.id}", arguments.params)
    end

    # @example
    # api.spaces.milestones.edit 'project1', 7, milestone: { is_completed: true }
    def edit(*args)
      arguments(args, required: [:space, :id]) do
        permit VALID_PARAMS_NAMES , recursive: true
        assert_values VALID_REQUEST_PARAM_VALUES
      end

      put_request("/spaces/#{arguments.space}/milestones/#{arguments.id}", arguments.params)
    end

    # Delete milestone by ID
    # @example
    # api.spaces.milestones.delete 'project1', 7
    def delete(*args)
      arguments(args, required: [:space, :id])
      delete_request("/spaces/#{arguments.space}/milestones/#{arguments.id}", arguments.params)
    end

    # @example
    # api.spaces.milestones.list 'project1'
    def list(*args)
      arguments(args, required: [:space])
      response = get_request("/spaces/#{arguments.space}/milestones", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end

    # @example
    # api.spaces.milestones.all 'project1'
    def all(*args)
      arguments(args, required: [:space])
      response = get_request("/spaces/#{arguments.space}/milestones/all", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end

    # @example
    # api.spaces.milestones.completed 'project1'
    def completed(*args)
      arguments(args, required: [:space])
      response = get_request("/spaces/#{arguments.space}/milestones/completed", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end

    # @example
    # api.spaces.milestones.upcoming 'project1'
    def upcoming(*args)
      arguments(args, required: [:space])
      response = get_request("/spaces/#{arguments.space}/milestones/upcoming", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end

    # @example
    # api.spaces.milestones.release_notes 'project1'
    def release_notes(*args)
      arguments(args, required: [:space])
      response = get_request("/spaces/#{arguments.space}/milestones/release_notes", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end
  end # milestones
end
