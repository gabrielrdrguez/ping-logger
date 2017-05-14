class ApplicationJob < ActiveJob::Base
  queue_as :default

  def perform(host)
    while true do
      if host.present?
        ping = `ping #{host} -c 1`
        ping_ms = /time=[[:digit:]]*/.match(ping).to_s.gsub('time=','')
        PingLog.create(log: ping, ping: ping_ms, ip: host)
        sleep 0.5
      else
        ping_uol = `ping 200.147.67.142 -c 1`
        ping_ms_uol = /time=[[:digit:]]*/.match(ping_uol).to_s.gsub('time=','')
        ping_vultr = `ping 45.32.171.18 -c 1`
        ping_ms_vultr = /time=[[:digit:]]*/.match(ping_vultr).to_s.gsub('time=','')
        ping_ramnode = `ping 107.191.103.239 -c 1`
        ping_ms_ramnode = /time=[[:digit:]]*/.match(ping_ramnode).to_s.gsub('time=','')
        time = Time.zone.now
        PingLog.create(log: ping_uol, ping: ping_ms_uol, ip: '200.147.67.142', created_at: time)
        PingLog.create(log: ping_vultr, ping: ping_ms_vultr, ip: '45.32.171.18', created_at: time)
        PingLog.create(log: ping_ramnode, ping: ping_ms_ramnode, ip: '107.191.103.239', created_at: time)
        sleep 0.5
      end
    end
  end
end
