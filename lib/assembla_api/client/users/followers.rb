# encoding: utf-8

module Assembla
  class Client::Users::Followers < API

    # List a user's followers
    #
    # @xample
    #  assembla = Assembla.new
    #  assembla.users.followers.list 'user-name'
    #  assembla.users.followers.list 'user-name' { |user| ... }
    #
    # List the authenticated user's followers
    #
    # @example
    #  assembla = Assembla.new oauth_token: '...'
    #  assembla.users.followers
    #  assembla.users.followers { |user| ... }
    #
    # @api public
    def list(*args)
      params = arguments(args).params

      response = if user_name = arguments.remaining.first
        get_request("/users/#{user_name}/followers", params)
      else
        get_request("/user/followers", params)
      end
      return response unless block_given?
      response.each { |el| yield el }
    end
    alias :all :list

    # List who a user is following
    #
    # @example
    #  assembla = Assembla.new
    #  assembla.users.followers.following 'user-name'
    #  assembla.users.followers.following 'user-name' { |user| ... }
    #
    # List who the authenicated user is following
    #
    # @example
    #  assembla = Assembla.new oauth_token: '...'
    #  assembla.users.followers.following
    #
    # @api public
    def following(*args)
      params = arguments(args).params

      response = if user_name = arguments.remaining.first
        get_request("/users/#{user_name}/following", params)
      else
        get_request("/user/following", params)
      end
      return response unless block_given?
      response.each { |el| yield el }
    end

    # Check if you are following a user
    #
    # @example
    #   assembla = Assembla.new oauth_token: '...'
    #   assembla.users.followers.following? 'user-name'
    #   assembla.users.followers.following? username: 'user-name'
    #
    # Check if one user follows another
    #
    # @example
    #   assembla = Assembla.new oauth_token: '...'
    #   assembla.users.followers.following? username: 'user-name',
    #     target_user: 'target-user-name'
    #
    # @api public
    def following?(*args)
      arguments(args, required: [:username])
      params = arguments.params
      if target_user = params.delete('target_user')
        get_request("/users/#{arguments.username}/following/#{target_user}", params)
      else
        get_request("/user/following/#{arguments.username}", params)
      end
      true
    rescue Assembla::Error::NotFound
      false
    end

    # Follow a user
    #
    # @example
    #  assembla = Assembla.new oauth_token: '...'
    #  assembla.users.followers.follow 'user-name'
    #  assembla.users.followers.follow username: 'user-name'
    #
    # @api public
    def follow(*args)
      arguments(args, required: [:username])
      put_request("/user/following/#{arguments.username}", arguments.params)
    end

    # Unfollow a user
    #
    # @example
    #  assembla = Assembla.new oauth_token: '...'
    #  assembla.users.followers.unfollow 'user-name'
    #  assembla.users.followers.unfollow username: 'user-name'
    #
    def unfollow(*args)
      arguments(args, required: [:username])
      delete_request("/user/following/#{arguments.username}", arguments.params)
    end
  end # Users::Followers
end # Assembla
