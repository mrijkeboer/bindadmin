class AddAllowQueriesTable < ActiveRecord::Migration

  def self.up
    create_table :allow_queries do |t|

      # Foreign keys
      t.integer :domain_id

      # General
      t.string :name,    :null => false
      t.string :clients, :null => false

      # Timestamps
      t.timestamps
    end
  end


  def self.down
    drop_table :allow_queries
  end

end
