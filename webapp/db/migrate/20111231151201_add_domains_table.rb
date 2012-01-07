class AddDomainsTable < ActiveRecord::Migration

  def self.up
    create_table :domains do |t|

      # Foreign keys
      t.integer :user_id

      # General
      t.string :name,    :null => false
      t.string :domtype, :null => false, :default => 'Native'
      t.string :master,  :null => true
      t.string :owner,   :null => true

      # Timestamps
      t.timestamps
    end
  end


  def self.down
    drop_table :domains
  end

end
