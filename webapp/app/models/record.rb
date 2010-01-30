class Record
	include MongoMapper::EmbeddedDocument

	# Attributes
	key :name, String
	key :ttl, String
	key :recclass, String, :default => 'IN'
	key :type, String
	key :pref, String
	key :content, String
	key :mname, String
	key :rname, String
	key :serial, String
	key :expire, String
	key :refresh, String
	key :retry, String
	key :minimum, String
	key :locked, Boolean, :default => false

	TYPES = [ 'NS', 'MX', 'A', 'AAAA', 'CNAME', 'PTR', 'SOA', 'TXT' ]
	OWNER_TYPES = [ 'A', 'CNAME', 'PTR', 'MX', 'NS', 'AAAA', 'TXT' ]

	# Validations
	validates_presence_of :type
	validates_inclusion_of :type, :within => Record::TYPES, :message => 'invalid type'

	validate :valid_a, :if => Proc.new { |r| r.a? }
	validate :valid_aaaa, :if => Proc.new { |r| r.aaaa? }
	validate :valid_cname, :if => Proc.new { |r| r.cname? }
	validate :valid_mx, :if => Proc.new { |r| r.mx? }
	validate :valid_ns, :if => Proc.new { |r| r.ns? }
	validate :valid_ptr, :if => Proc.new { |r| r.ptr? }
	validate :valid_soa, :if => Proc.new { |r| r.soa? }
	validate :valid_txt, :if => Proc.new { |r| r.txt? }


	def domain
		return self._root_document
	end


	def name=(val)
		self[:name] = val.to_s.downcase
	end


	def fqdn_name
		if (name =~ /^.*\.$/) == nil
			return name + '.' + self.domain.name + '.'
		else
			return name
		end
	end


	def ttl=(val)
		self[:ttl] = val.to_s.downcase
	end


	def recclass=(val)
		self[:recclass] = 'IN'
	end


	def type=(val)
		self[:type] = val.to_s.upcase
	end


	def content
		if self.soa?
			return "#{@mname} #{@rname} #{@serial.to_s} #{@refresh} #{@retry} #{@expire} #{@minimum}"
		else
			return self[:content]
		end
	end


	def content=(val)
		self[:content] = val.to_s.downcase
	end


	def mname=(val)
		self[:mname] = val.to_s.downcase
	end


	def rname=(val)
		self[:rname] = val.to_s.downcase
	end


	def serial=(val)
		self[:serial] = val
	end
	

	def refresh=(val)
		self[:refresh] = val.to_s.downcase
	end


	def retry=(val)
		self[:retry] = val.to_s.downcase
	end


	def expire=(val)
		self[:expire] = val.to_s.downcase
	end


	def minimum=(val)
		self[:minimum] = val.to_s.downcase
	end


	def locked
		if self.soa?
			return true
		else
			return self[:locked]
		end
	end


	def a?
		return self.type.to_s.upcase == 'A'
	end


	def aaaa?
		return self.type.to_s.upcase == 'AAAA'
	end


	def cname?
		return self.type.to_s.upcase == 'CNAME'
	end


	def mx?
		return self.type.to_s.upcase == 'MX'
	end


	def ns?
		return self.type.to_s.upcase == 'NS'
	end


	def ptr?
		return self.type.to_s.upcase == 'PTR'
	end

	def soa?
		return self.type.to_s.upcase == 'SOA'
	end


	def txt?
		return self.type.to_s.upcase == 'TXT'
	end


	def Record.default_records(domain_name)
		default = Default.instance
		records = []

		# soa record
		records << Record.new(
			:name => "#{domain_name}.",
			:ttl => default.ttl,
			:type => 'SOA',
			:mname => default.mname,
			:rname => default.rname,
			:serial => default.serial,
			:expire => default.expire,
			:refresh => default.refresh,
			:retry => default.retry,
			:minimum => default.minimum,
			:locked => true
		)

		# ns records
		for server in default.name_servers
			records << Record.new(
				:name => "#{domain_name}.",
				:ttl => server.ttl,
				:type => 'NS',
				:content => server.fqdn,
				:locked => true
			)
		end

		# mx records
		for server in default.mail_servers
			records << Record.new(
				:name => "#{domain_name}.",
				:ttl => server.ttl,
				:type => 'MX',
				:pref => server.pref,
				:content => server.fqdn,
				:locked => true
			)
		end

		return records
	end


	private


	def valid_a
		Validate::Dns.validate_name(name, errors, :name)
		Validate::Dns.validate_time(ttl, errors, :ttl, true)
		Validate::Dns.validate_no_pref(pref, errors, :pref)
		Validate::Dns.validate_ipv4(content, errors, :content)
	end


	def valid_aaaa
		Validate::Dns.validate_name(name, errors, :name)
		Validate::Dns.validate_time(ttl, errors, :ttl, true)
		Validate::Dns.validate_no_pref(pref, errors, :pref)
		Validate::Dns.validate_ipv6(content, errors, :content)
	end


	def valid_cname
		Validate::Dns.validate_name(name, errors, :name)
		Validate::Dns.validate_time(ttl, errors, :ttl, true)
		Validate::Dns.validate_no_pref(pref, errors, :pref)
		Validate::Dns.validate_name(content, errors, :content)
	end


	def valid_mx
		Validate::Dns.validate_name(name, errors, :name)
		Validate::Dns.validate_time(ttl, errors, :ttl, true)
		Validate::Dns.validate_pref(pref, errors, :pref)
		Validate::Dns.validate_name(content, errors, :content)
	end


	def valid_ns
		Validate::Dns.validate_name(name, errors, :name)
		Validate::Dns.validate_time(ttl, errors, :ttl, true)
		Validate::Dns.validate_no_pref(pref, errors, :pref)
		Validate::Dns.validate_name(content, errors, :content)
	end


	def valid_ptr
		Validate::Dns.validate_name(name, errors, :name)
		Validate::Dns.validate_time(ttl, errors, :ttl, true)
		Validate::Dns.validate_no_pref(pref, errors, :pref)
		Validate::Dns.validate_name(content, errors, :content)
	end


	def valid_soa
		Validate::Dns.validate_name(name, errors, :name)
		Validate::Dns.validate_time(ttl, errors, :ttl)
		Validate::Dns.validate_no_pref(pref, errors, :pref)
		Validate::Dns.validate_name(@mname, errors, :mname)
		Validate::Dns.validate_name(@rname, errors, :rname)
		Validate::Dns.validate_serial(@serial, errors, :serial)
		Validate::Dns.validate_time(@refresh, errors, :refresh)
		Validate::Dns.validate_time(@retry, errors, :retry)
		Validate::Dns.validate_time(@expire, errors, :expire)
		Validate::Dns.validate_time(@minimum, errors, :minimum)
	end


	def valid_txt
		Validate::Dns.validate_name(name, errors, :name)
		Validate::Dns.validate_time(ttl, errors, :ttl, true)
		Validate::Dns.validate_no_pref(pref, errors, :pref)
		Validate::Dns.validate_txt(content, errors, :content)
	end

end
