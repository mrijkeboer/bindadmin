class Domain
	include MongoMapper::Document

	# Attributes
	key :user_id, ObjectId
	key :name, String
	key :type, String, :default => 'Native'
	key :master, String
	key :owner, String     # Cached

	timestamps!

	TYPES = [ 'Native', 'Slave' ]

	# Relationships
	many :allow_queries
	many :records
	belongs_to :user

	# Validation
	validates_presence_of :user
	validates_uniqueness_of :name
	validates_presence_of :type

	validates_inclusion_of :type, :within => Domain::TYPES, :message => 'invalid type'

	validates_length_of :owner, :within => 0..250

	validate :valid_native, :if => Proc.new { |d| d.native? }
	validate :valid_slave, :if => Proc.new { |d| d.slave? }

	validates_associated :allow_queries, :records


	def before_create
		if self.native?
			for record in Record.default_records(self.name)
				self.records << record
			end
		end
	end


	def before_save
		self.owner = self.user.fullname
	end


	def native?
		return self.type.upcase == 'NATIVE'
	end


	def slave?
		return self.type.upcase == 'SLAVE'
	end


	def Domain.changed(timestamp = 0)
		return Domain.find(:all, :conditions => {:updated_at => { '$gt' => Time.at(timestamp.to_i) }} )
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
