require 'validate/dns'

class MailServer < ActiveRecord::Base

  belongs_to :default

	# Validations
	validate :valid_values


	def fqdn=(val)
		self[:fqdn] = val.to_s.downcase
	end


	def ttl=(val)
		self[:ttl] = val.to_s.downcase
	end


	private


	def valid_values
		Validate::Dns.validate_fqdn(fqdn, errors, :fqdn)
		Validate::Dns.validate_pref(pref, errors, :pref)
		Validate::Dns.validate_time(ttl, errors, :ttl, true)
	end

end
