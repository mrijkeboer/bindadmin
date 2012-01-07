class AddRecordsTable < ActiveRecord::Migration

  def self.up
    create_table :records do |t|

      # Foreign keys
      t.integer :domain_id

      # General
      t.string  :name,     :null => false
      t.string  :ttl,      :null => true
      t.string  :recclass, :null => false, :default => 'IN'
      t.string  :rectype,  :null => false
      t.string  :pref,     :null => true
      t.string  :content,  :null => true
      t.string  :mname,    :null => true
      t.string  :rname,    :null => true
      t.string  :serial,   :null => true
      t.string  :expire,   :null => true
      t.string  :refresh,  :null => true
      t.string  :retry,    :null => true
      t.string  :minimum,  :null => true
      t.boolean :locked,   :null => false, :default => false

      # Timestamps
      t.timestamps
    end
  end


  def self.down
    drop_table :records
  end

end
