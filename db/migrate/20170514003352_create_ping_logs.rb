class CreatePingLogs < ActiveRecord::Migration[5.1]

  def change
    drop_table :ping_logs
    create_table :ping_logs do |t|
      t.string 'log'
      t.string 'ping'
      t.string 'ip'
      t.timestamps
    end
  end
end
