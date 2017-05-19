# module ActiveRecord
#   class QueryCache
#     module ClassMethods
#       # Desabilita globalmente o QueryCache, que gera um pseudo memory leak ao
#       # funcionar em uma tarefa rake contínua.
#       def cache(&block)
#         yield
#       end
#     end
#   end
# end

namespace :ping do

  task start: :environment do
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    Rails.logger.level = Logger::DEBUG
    sleep_seconds = 0.1
    while true do
      ping_linode_atlanta = `ping 50.116.39.117 -c 1`
      ping_ms_linode_atlanta = /time=[[:digit:]]*/.match(ping_linode_atlanta).to_s.gsub('time=','').to_i
      ping_uol = `ping 200.147.67.142 -c 1`
      ping_ms_uol = /time=[[:digit:]]*/.match(ping_uol).to_s.gsub('time=','').to_i
      ping_vultr_atlanta = `ping 45.32.213.58 -c 1`
      ping_ms_vultr = /time=[[:digit:]]*/.match(ping_vultr_atlanta).to_s.gsub('time=','').to_i
      ping_ramnode = `ping 107.191.103.239 -c 1`
      ping_ms_ramnode = /time=[[:digit:]]*/.match(ping_ramnode).to_s.gsub('time=','').to_i
      time = Time.zone.now
      ActiveRecord::Base.transaction do
        PingLog.create(log: ping_uol, ping: ping_ms_uol, ip: '200.147.67.142', created_at: time)
        PingLog.create(log: ping_vultr_atlanta, ping: ping_ms_vultr, ip: '45.32.213.58', created_at: time)
        PingLog.create(log: ping_ramnode, ping: ping_ms_ramnode, ip: '107.191.103.239', created_at: time)
        PingLog.create(log: ping_linode_atlanta, ping: ping_ms_linode_atlanta, ip: '50.116.39.117', created_at: time)
      end
      sleep sleep_seconds
    end
  end
end
