class AddUsersTable < ActiveRecord::Migration

  def self.up
    create_table :users do |t|

      # General
      t.string :username,      :null => false
      t.string :password_hash, :null => true
      t.string :fullname,      :null => false
      t.string :role,          :null => false, :default => 'Owner'

      # Timestamps
      t.timestamps
    end

    add_index :users, :username
  end

  def self.down
    drop_table :users
  end

end
