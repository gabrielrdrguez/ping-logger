class CreatePingLogs < ActiveRecord::Migration[5.1]

  def change
    create_table :ping_logs do |t|
      t.string 'log',  limit: 300
      t.integer 'ping'
      t.string 'ip', limit: 15
      t.timestamps
    end

    create_table :ips do |t|
      t.string 'ip',  limit: 15
      t.string 'descricao'
      t.string 'localidade'
      t.timestamps
    end

  end
end
