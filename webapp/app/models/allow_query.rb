class AllowQuery < ActiveRecord::Base

  belongs_to :domain

	# Foreign keys
  validates :domain_id, :presence => true

  # General
	validates :name,    :presence => true, :length => { :within => 3..250 }
	validates :clients, :presence => true, :length => { :within => 3..2048 }

end
