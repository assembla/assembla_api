module Assembla
  class Client::Spaces::WikiPages::Versions < API

    # @example
    # api.spaces.wiki_pages.versions.get 'project1', 'wiki-guid', 369
    def get(*args)
      arguments(args, required: [:space, :wiki_guid, :id])
      get_request("/spaces/#{arguments.space}/wiki_pages/#{arguments.wiki_guid}/versions/#{arguments.id}", arguments.params)
    end

    # @example
    # api.spaces.wiki_pages.versions.list 'project1', 'wiki-guid'
    def list(*args)
      arguments(args, required: [:space, :wiki_guid])
      response = get_request("/spaces/#{arguments.space}/wiki_pages/#{arguments.wiki_guid}/versions", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end
  end # versions
end
