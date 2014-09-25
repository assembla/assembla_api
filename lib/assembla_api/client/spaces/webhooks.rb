module Assembla
  class Client::Spaces::Webhooks < API

    VALID_PARAMS_NAMES = %w[
      title
      enabled
      authentication_type
      app_api_key
      app_secret
      app_request_token_url
      app_access_token_url
      app_authorize_url
      app_authorize_query
      access_token
      access_token_secret
      external_url
      http_method
      content_type
      content
      filter
    ].freeze

    BASIC_AUTH = 1

    VALID_REQUEST_PARAM_VALUES = {
      'enabled' => [true, false],
      'authentication_type' => [1, 2],
      'http_method' => [0, 1]
    }

    # @example
    # api.spaces.webhooks.create 'project1', webhook: { title: 'Mobile App V2', external_url: 'http://example.com/notify' }
    def create(*args)
      arguments(args, required: [:space]) do
        permit VALID_PARAMS_NAMES, recursive: true
        assert_required %w[ external_url ]
        assert_values VALID_REQUEST_PARAM_VALUES
      end

      arguments.params['webhook']['authentication_type'] ||= BASIC_AUTH
      post_request("/spaces/#{arguments.space}/webhooks", arguments.params)
    end

    # @example
    # api.spaces.webhooks.edit 'project1', 699, webhook: { enabled: false }
    def edit(*args)
      arguments(args, required: [:space, :id]) do
        permit VALID_PARAMS_NAMES , recursive: true
        assert_values VALID_REQUEST_PARAM_VALUES
      end

      put_request("/spaces/#{arguments.space}/webhooks/#{arguments.id}", arguments.params)
    end

    # Delete webhook by ID
    # @example
    # api.spaces.webhooks.delete 'project1', 699
    def delete(*args)
      arguments(args, required: [:space, :id])
      delete_request("/spaces/#{arguments.space}/webhooks/#{arguments.id}", arguments.params)
    end
  end # webhooks
end
