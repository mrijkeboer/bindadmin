require 'validate/dns'

class Default
	include MongoMapper::Document

	# Attributes
	key :ttl, String, :default => '24h'
	key :mname, String, :default => 'ns1.example.com.'
	key :rname, String, :default => 'root.example.com.'
	key :serial, String, :default => '1'
	key :refresh, String, :default => '1h'
	key :retry, String, :default => '10m'
	key :expire, String, :default => '41d'
	key :minimum, String, :default => '1h'

	# Relationships
	many :mail_servers
	many :name_servers

	# Validations
	validate :valid_defaults
	validates_associated :mail_servers, :name_servers


	def Default.instance
		if Default.count > 0
			return Default.first
		else
			return Default.create!
		end
	end


	private


	def valid_defaults
		Validate::Dns.validate_time(ttl, errors, :ttl)
		Validate::Dns.validate_fqdn(mname, errors, :mname)
		Validate::Dns.validate_fqdn(rname, errors, :rname)
		Validate::Dns.validate_serial(serial, errors, :serial)
		Validate::Dns.validate_time(refresh, errors, :refresh)
		Validate::Dns.validate_time(self.retry, errors, :retry)
		Validate::Dns.validate_time(expire, errors, :expire)
		Validate::Dns.validate_time(minimum, errors, :minimum)
	end

end
