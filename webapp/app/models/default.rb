require 'validate/dns'

class Default < ActiveRecord::Base

	has_many :mail_servers
	has_many :name_servers

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
