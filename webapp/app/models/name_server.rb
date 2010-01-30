class NameServer
	include MongoMapper::EmbeddedDocument

	# Attributes
	key :fqdn, String
	key :ttl, String

	# Validations
	validate :valid_values


	def default
		return self._root_document
	end


	def fqdn=(val)
		self[:fqdn] = val.to_s.downcase
	end


	def ttl=(val)
		self[:ttl] = val.to_s.downcase
	end

	
	private


	def valid_values
		Validate::Dns.validate_fqdn(fqdn, errors, :fqdn)
		Validate::Dns.validate_time(ttl, errors, :ttl, true)
	end

end
