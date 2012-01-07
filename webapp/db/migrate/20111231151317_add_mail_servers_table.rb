class AddMailServersTable < ActiveRecord::Migration

  def self.up
    create_table :mail_servers do |t|

      # Foreign keys
      t.integer :default_id

      # General
      t.string :fqdn, :null => false
      t.string :ttl,  :null => true
      t.string :pref, :null => false

      # Timestamps
      t.timestamps
    end
  end


  def self.down
    drop_table :mail_servers
  end

end
