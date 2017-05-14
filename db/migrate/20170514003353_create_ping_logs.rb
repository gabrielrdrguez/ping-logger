class CreatePingLogs < ActiveRecord::Migration[5.1]

  def change
    create_table :ping_logs do |t|
      t.string 'log',  limit: 300
      t.integer 'ping'
      t.string 'ip', limit: 15
      t.timestamps
    end
  end
end
