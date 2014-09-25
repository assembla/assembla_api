module Assembla
  class Client::Spaces::Ssh < API
    require_all 'assembla_api/client/spaces/ssh',
      'keys',
      'servers',
      'actions'

    namespace :keys
    namespace :servers
    namespace :actions
  end
end
