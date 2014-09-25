module Assembla
  class Client::Spaces::WikiPages < API

    VALID_PARAMS_NAMES = %w[
      page_name
      contents
      parent_id
      position
      status
      wiki_format
      change_comment
    ].freeze

    VALID_REQUEST_PARAM_VALUES = {
      'status' => [0, 1, 2],
      'wiki_format' => [0, 1, 2, 3, 4, 5]
    }

    # @example
    # api.spaces.wiki_pages.create 'project1', wiki_page: { page_name: 'Mobile App V2' }
    def create(*args)
      arguments(args, required: [:space]) do
        permit VALID_PARAMS_NAMES, recursive: true
        assert_required %w[ page_name ]
        assert_values VALID_REQUEST_PARAM_VALUES
      end

      post_request("/spaces/#{arguments.space}/wiki_pages", arguments.params)
    end

    # @example
    # api.spaces.wiki_pages.get 'project1', 'guid'
    def get(*args)
      arguments(args, required: [:space, :id])
      get_request("/spaces/#{arguments.space}/wiki_pages/#{arguments.id}", arguments.params)
    end

    # @example
    # api.spaces.wiki_pages.edit 'project1', 'guid', wiki_page: { position: 1 }
    def edit(*args)
      arguments(args, required: [:space, :id]) do
        permit VALID_PARAMS_NAMES , recursive: true
        assert_values VALID_REQUEST_PARAM_VALUES
      end

      put_request("/spaces/#{arguments.space}/wiki_pages/#{arguments.id}", arguments.params)
    end

    # Deletes wiki page by ID and all its children
    #
    # @example
    # api.spaces.wiki_pages.delete 'project1', 'guid'
    def delete(*args)
      arguments(args, required: [:space, :id])
      delete_request("/spaces/#{arguments.space}/wiki_pages/#{arguments.id}/all", arguments.params)
    end

    # Deletes wiki page by ID and moves all children with one level up
    #
    # @example
    # api.spaces.wiki_pages.delete_parent 'project1', 'guid'
    def delete_parent(*args)
      arguments(args, required: [:space, :id])
      delete_request("/spaces/#{arguments.space}/wiki_pages/#{arguments.id}/container", arguments.params)
    end

    # @example
    # api.spaces.wiki_pages.list 'project1'
    def list(*args)
      arguments(args, required: [:space])
      response = get_request("/spaces/#{arguments.space}/wiki_pages", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end
  end # wiki_pages
end
