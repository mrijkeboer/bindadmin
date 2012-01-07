class AddDefaultsTable < ActiveRecord::Migration

  def self.up
    create_table :defaults do |t|

      # General
      t.string :ttl,     :null => false, :default => '24h'
      t.string :mname,   :null => false, :default => 'ns1.example.com.'
      t.string :rname,   :null => false, :default => 'root.example.com.'
      t.string :serial,  :null => false, :default => '1'
      t.string :refresh, :null => false, :default => '1h'
      t.string :retry,   :null => false, :default => '10m'
      t.string :expire,  :null => false, :default => '41d'
      t.string :minimum, :null => false, :default => '1h'

      # Timestamps
      t.timestamps
    end
  end


  def self.down
    drop_table :defaults
  end

end
