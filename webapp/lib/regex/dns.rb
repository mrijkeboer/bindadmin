class Regex::Dns
	
	def self.check_characters(name)
		return true
	end
	
	
	def self.check_domain_name(name)
		return (name =~ /^([-a-z0-9]+\.)+[a-z]{2,}$/) != nil
	end
	
	
	def self.check_master(master)
		if self.check_domain_name(master)
			return true
		elsif self.check_ipv4(master)
			return true
		elsif self.check_ipv6(master)
			return true
		else
			return false
		end
	end
	
	
	def self.check_ipv4(ipv4)
		@ipv4_format = Regexp.new(/^([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$/)
		return @ipv4_format.match(ipv4) != nil
	end
	
	
	def self.check_ipv6(ipv6)
		return (ipv6 =~ /^[0-9a-f:]+$/) != nil
	end
	
	
	def self.check_fqdn(fqdn)
		# must end with '.'
		return false if (fqdn =~ /^.*\.$/) == nil
		# can't start with '-'
		return false if (fqdn =~ /^-.*$/) != nil
		# can't end with '-.'
		return false if (fqdn =~ /^.*-\.$/) != nil
		# check characters and layout
		return (fqdn =~ /^([-a-z0-9]+\.)+[a-z]{2,}\.$/) != nil
	end
	
	
	def self.check_name(name)
		# can't be IPv4 address.
		return false if Regex::Dns.check_ipv4(name) == true
		# can't end with '.'
		return false if (name =~ /^.*\.$/) != nil
		# can't start with '-'
		return false if (name =~ /^-.*$/) != nil
		# can't end with '-'
		return false if (name =~ /^.*-$/) != nil
		return (name =~ /^[-a-z0-9\.]+$/) != nil
	end
	
	
	def self.check_time(time)
		return (time.to_s =~ /^[1-9]+[0-9]*[smhdw]{0,1}$/) != nil
	end
	
	
	def self.check_preference(pref)
		return (pref.to_s =~ /\A\d+\Z/) != nil
	end
	
	
	def self.check_serial(serial)
		return (serial.to_s =~ /\A\d+\Z/) != nil
	end
	
	
	def self.ends_with_dot(name)
		return (name =~ /^.*\.$/) != nil
	end
	
	
	def self.ends_with_dot!(name)
		if name.to_s == ""
			return name
		elsif self.ends_with_dot(name) == false
			return name + "."
		else
			return name
		end
	end
	
end
