class AddNameServersTable < ActiveRecord::Migration

  def self.up
    create_table :name_servers do |t|

      # Foreign keys
      t.integer :default_id

      # General
      t.string :fqdn, :null => false
      t.string :ttl,  :null => true

      # Timestamps
      t.timestamps
    end
  end


  def self.down
    drop_table :name_servers
  end

end
