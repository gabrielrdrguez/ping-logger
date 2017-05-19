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
    sleep_seconds = 0.2
    last_check = Time.zone.now
    ip_array = []
    while true do
      ActiveRecord::Base.transaction do
        if (last_check - Time.zone.now) < 30.seconds
          ip_array = Ip.pluck(:ip)
          last_check = Time.zone.now
        end

        ip_array.each do |ip|
          ping_log = `ping #{ip} -c 1`
          ping_val = /time=[[:digit:]]*/.match(ping_log).to_s.gsub('time=','').to_i
          PingLog.create(log: ping_log, ping: ping_val, ip: ip, created_at: Time.zone.now)
        end
        sleep sleep_seconds
      end
    end
  end
end
