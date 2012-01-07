class AddServersTable < ActiveRecord::Migration

  def self.up
    create_table :servers do |t|

      # General
      t.string :servername,    :null => false
      t.string :password_hash, :null => true

      # Timestamps
      t.timestamps
    end

    add_index :servers, :servername
  end


  def self.down
    drop_table :servers
  end

end
