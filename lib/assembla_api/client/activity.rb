# encoding: utf-8

module Assembla
  class Client::Activity < API

    require_all 'assembla_api/client/activity',
      'events',
      'notifications',
      'starring',
      'watching'

    # Access to Activity::Events API
    namespace :events

    # Access to Activity::Notifications API
    namespace :notifications

    # Access to Activity::Starring API
    namespace :starring

    # Access to Activity::Watching API
    namespace :watching

  end # Activity
end # Assembla
