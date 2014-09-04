# encoding: utf-8

require 'assembla_api/utils/url'
require 'uri'

module Assembla
  class PageIterator
    include Assembla::Constants
    include Assembla::Utils::Url
    include Assembla::PagedRequest

    # Setup attribute accesor for all the link types
    ATTRIBUTES = [ META_FIRST, META_NEXT, META_PREV, META_LAST ]

    DEFAULT_SHA = 'master'

    ATTRIBUTES.each do |attr|
      attr_accessor :"#{attr}_page_uri", :"#{attr}_page"
    end

    attr_reader :current_api

    def initialize(links, current_api)
      @links       = links
      @current_api = current_api
      update_page_links @links
    end

    def has_next?
      next_page == 0 || !next_page_uri.nil?
    end

    def count
      return nil unless last_page_uri
      parse_query(URI(last_page_uri).query)['page']
    end

    # Perform http get request for the first resource
    #
    def first
      return nil unless first_page_uri
      perform_request(first_page_uri)
    end

    # Perform http get request for the next resource
    #
    def next
      return nil unless has_next?
      perform_request(next_page_uri)
    end

    # Perform http get request for the previous resource
    #
    def prev
      return nil unless prev_page_uri
      perform_request(prev_page_uri)
    end

    # Perform http get request for the last resource
    #
    def last
      return nil unless last_page_uri
      perform_request(last_page_uri)
    end

    # Returns the result for a specific page.
    #
    def get_page(page_number)
      # Find URI that we can work with, if we cannot get the first or the
      # last page URI then there is only one page.
      page_uri = first_page_uri || last_page_uri
      return nil unless page_uri
      params = parse_query URI(page_uri).query
      params['page']     = page_number
      params['per_page'] = parse_per_page_number(page_uri)

      response = page_request URI(page_uri).path, params
      update_page_links response.links
      response
    end

  private

    def perform_request(attribute)
      page_uri = URI(attribute)
      params = parse_query(page_uri.query)

      if next_page < 1
        sha = sha(params)
        params['sha'] = sha if sha
      else
        params['page'] = parse_page_number(attribute)
      end
      params['per_page'] = parse_per_page_number(attribute)

      response = page_request(page_uri.path, params)
      update_page_links response.links
      response
    end

    def sha(params)
      return params['last_sha'] if params.keys.include?('last_sha')
      return DEFAULT_SHA if params.keys.include?('sha')
      nil
    end

    def parse_per_page_number(uri) # :nodoc:
      parse_page_params(uri, PARAM_PER_PAGE)
    end

    def parse_page_number(uri) # :nodoc:
      parse_page_params(uri, PARAM_PAGE)
    end

    # Extracts query string parameter for given name
    def parse_page_params(uri, attr) # :nodoc:
      return -1 if uri.nil? || uri.empty?
      parsed = nil
      begin
        parsed = URI.parse(uri)
      rescue URI::Error => e
        return -1
      end
      param = parse_query_for_param(parsed.query, attr)
      return -1 if param.nil? || param.empty?
      begin
        return param.to_i
      rescue ArgumentError => err
        return -1
      end
    end

    # Wholesale update of all link attributes
    def update_page_links(links) # :nodoc:
      ATTRIBUTES.each do |attr|
        self.send(:"#{attr}_page_uri=", links.send(:"#{attr}"))
        self.send(:"#{attr}_page=", parse_page_number(links.send(:"#{attr}")))
      end
    end

  end # PageIterator
end # Assembla
