module Assembla
  class Client::Spaces::Ssh < API
    require_all 'assembla_api/client/spaces/ssh',
      'keys',
      'servers',
      'actions',
      'launches'

    namespace :keys
    namespace :servers
    namespace :actions
    namespace :launches
  end
end
