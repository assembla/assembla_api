require "mime/types"

module Assembla
  class Client::Spaces::Documents < API

    VALID_PARAMS_NAMES = %w[
      file
      filename
      name
      description
      position
      cached_tag_list
      attachable_type
      attachable_guid
      attachable_id
    ].freeze

    VALID_REQUEST_PARAM_VALUES = {
      'attachable_type' => /^(Ticket|Flow|Milestone)$/
    }

    # @example
    # api.spaces.documents.create 'project1', document: { file: '/path/to/file' }
    def create(*args)
      arguments(args, required: [:space]) do
        permit VALID_PARAMS_NAMES, recursive: true
        assert_required %w[ file ]
        assert_values VALID_REQUEST_PARAM_VALUES
      end

      doc = arguments.params.delete 'document'
      path = doc['file']
      name = File.basename(path)
      mime = MIME::Types.of(name).first
      file = Faraday::UploadIO.new(path, mime ? mime.content_type : 'application/octet-stream')
      doc['name'] ||= name
      doc['file'] = file
      arguments.params['data'] = { 'document' => doc }
      arguments.params['options'] = { headers: { content_type: 'multipart/form-data' }}

      post_request("/spaces/#{arguments.space}/documents", arguments.params)
    end

    # @example
    # api.spaces.documents.get 'project1', 'guid'
    def get(*args)
      arguments(args, required: [:space, :id])
      get_request("/spaces/#{arguments.space}/documents/#{arguments.id}", arguments.params)
    end

    # @example
    # api.spaces.documents.download 'project1', 'guid'
    def download(*args)
      arguments(args, required: [:space, :id])
      arguments.params['raw'] = true
      get_request("/spaces/#{arguments.space}/documents/#{arguments.id}/download", arguments.params)
    end

    # @example
    # api.spaces.documents.edit 'project1', 'guid', document: { description: "Confidential" }
    def edit(*args)
      arguments(args, required: [:space, :id]) do
        permit VALID_PARAMS_NAMES , recursive: true
        assert_values VALID_REQUEST_PARAM_VALUES
      end

      put_request("/spaces/#{arguments.space}/documents/#{arguments.id}", arguments.params)
    end

    # Delete document by ID
    # @example
    # api.spaces.documents.delete 'project1', 'guid'
    def delete(*args)
      arguments(args, required: [:space, :id])
      delete_request("/spaces/#{arguments.space}/documents/#{arguments.id}", arguments.params)
    end

    # @example
    # api.spaces.documents.list 'project1'
    def list(*args)
      arguments(args, required: [:space])
      response = get_request("/spaces/#{arguments.space}/documents", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end
  end # documents
end
