require 'validate/dns'

class Domain < ActiveRecord::Base

	TYPES = [ 'Native', 'Slave' ]

	belongs_to :user
	has_many :allow_queries
	has_many :records

	# Validation
	validates_presence_of :user
	validates_uniqueness_of :name

	validates_presence_of :domtype
	validates_inclusion_of :domtype, :in => Domain::TYPES, :message => 'invalid type'

	validates_length_of :owner, :within => 0..250, :allow_nil => true, :allow_blank => true

	validate :valid_native, :if => Proc.new { |d| d.native? }
	validate :valid_slave, :if => Proc.new { |d| d.slave? }

	validates_associated :allow_queries, :records

	before_create :create_records
	before_save :set_owner


	def create_records
		if self.native?
			for record in Record.default_records(self.name)
				self.records << record
			end
		end
	end


	def set_owner
		self.owner = self.user.fullname
	end


	def native?
		return self.domtype.upcase == 'NATIVE'
	end


	def slave?
		return self.domtype.upcase == 'SLAVE'
	end


	def Domain.changed(timestamp = 0)
		return Domain.where("updated_at > ?", Time.at(timestamp.to_i)).all
	end


	private


	def valid_native
		Validate::Dns.validate_domain_name(name, errors, :name)
		Validate::Dns.validate_no_master(master, errors, :master)
	end


	def valid_slave
		Validate::Dns.validate_domain_name(name, errors, :name)
		Validate::Dns.validate_master(master, errors, :master)
	end

end
