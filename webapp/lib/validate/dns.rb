require 'regex/dns'

module Validate

	class Dns

		def self.validate_domain_name(val, errors, field)
			if val.to_s.length == 0
				errors.add(field, "can't be blank")
			elsif val.to_s.length > 250
				errors.add(field, "too long (250 characters maximum)")
			elsif Regex::Dns.check_domain_name(val) == false
				errors.add(field, "invalid domain name")
			end
		end


		def self.validate_master(val, errors, field)
			if val.to_s.length == 0
				errors.add(field, "can't be blank")
			elsif val.to_s.length > 250
				errors.add(field, "too long (250 characters maximum)")
			elsif Regex::Dns.check_master(val) == false
				errors.add(field, "invalid master")
			end
		end


		def self.validate_no_master(val, errors, field)
			if val.to_s.length > 0
				errors.add(field, "must be blank")
			end
		end


		def self.validate_fqdn(val, errors, field)
			if val.to_s.length == 0
				errors.add(field, "can't be blank")
			elsif val.to_s.length > 250
				errors.add(field, "too long (250 characters maximum)")
			elsif Regex::Dns.check_fqdn(val) == false
				errors.add(field, "invalid fqdn")
			end
		end


		def self.validate_name(val, errors, field)
			if val.to_s.length == 0
				errors.add(field, "can't be blank")
			elsif val.to_s.length > 250
				errors.add(field, "too long (250 characters maximum)")
			elsif Regex::Dns.check_fqdn(val) == false
				if Regex::Dns.check_name(val) == false
					errors.add(field, "invalid name")
				end
			end
		end


		def self.validate_time(val, errors, field, allow_nil = false)
			if val.to_s.length == 0
				if allow_nil == false
					errors.add(field, "can't be blank")
				end
			elsif val.to_s.length > 12
				errors.add(field, "too long (12 characters maximum)")
			elsif Regex::Dns.check_time(val) == false
				errors.add(field, "invalid time value")
			end
		end


		def self.validate_pref(val, errors, field)
			if val.to_s.length == 0
				errors.add(field, "can't be blank")
			elsif Regex::Dns.check_preference(val) == false
				errors.add(field, "invalid number")
			elsif val.to_i < 1
				errors.add(field, "too low (minimum 1)")
			elsif val.to_i > 9999
				errors.add(field, "too high (maximum 9999)")
			end
		end


		def self.validate_no_pref(val, errors, field)
			if val.to_s.length > 0
				errors.add(field, "must be blank")
			end
		end


		def self.validate_ipv4(val, errors, field)
			if val.to_s.length == 0
				errors.add(field, "can't be blank")
			elsif val.to_s.length > 250
				errors.add(field, "too long (250 characters maximum)")
			elsif Regex::Dns.check_ipv4(val) == false
				errors.add(field, "invalid IPv4 address")
			end
		end


		def self.validate_ipv6(val, errors, field)
			if val.to_s.length == 0
				errors.add(field, "can't be blank")
			elsif val.to_s.length > 250
				errors.add(field, "too long (250 characters maximum)")
			elsif Regex::Dns.check_ipv6(val) == false
				errors.add(field, "invalid IPv6 address")
			end
		end


		def self.validate_txt(val, errors, field)
			if val.to_s.length == 0
				errors.add(field, "can't be blank")
			elsif val.to_s.length > 250
				errors.add(field, "too long (250 characters maximum)")
			elsif Regex::Dns.check_characters(val) == false
				errors.add(field, "invalid character(s)")
			end
		end


		def self.validate_serial(val, errors, field)
			if val.to_s.length == 0
				errors.add(field, "can't be blank")
			elsif Regex::Dns.check_serial(val) == false
				errors.add(field, "invalid number")
			elsif val.to_i < 1
				errors.add(field, "too low (minimum 1)")
			elsif val.to_i > 9999999999
				errors.add(field, "too high (maximum 9999999999)")
			end
		end

	end

end
