require 'validate/dns'

class Record < ActiveRecord::Base

	TYPES = [ 'NS', 'MX', 'A', 'AAAA', 'CNAME', 'PTR', 'SOA', 'TXT' ]
	OWNER_TYPES = [ 'A', 'CNAME', 'PTR', 'MX', 'NS', 'AAAA', 'TXT' ]

  belongs_to :domain

	# Validations
	validates_presence_of :rectype
	validates_inclusion_of :rectype, :in => Record::TYPES, :message => 'invalid type'

	validate :valid_a, :if => Proc.new { |r| r.a? }
	validate :valid_aaaa, :if => Proc.new { |r| r.aaaa? }
	validate :valid_cname, :if => Proc.new { |r| r.cname? }
	validate :valid_mx, :if => Proc.new { |r| r.mx? }
	validate :valid_ns, :if => Proc.new { |r| r.ns? }
	validate :valid_ptr, :if => Proc.new { |r| r.ptr? }
	validate :valid_soa, :if => Proc.new { |r| r.soa? }
	validate :valid_txt, :if => Proc.new { |r| r.txt? }


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


	def rectype=(val)
		self[:rectype] = val.to_s.upcase
	end


	def content
		if self.soa?
			return "#{mname} #{rname} #{serial.to_s} #{refresh} #{self.retry} #{expire} #{minimum}"
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
		return self.rectype.to_s.upcase == 'A'
	end


	def aaaa?
		return self.rectype.to_s.upcase == 'AAAA'
	end


	def cname?
		return self.rectype.to_s.upcase == 'CNAME'
	end


	def mx?
		return self.rectype.to_s.upcase == 'MX'
	end


	def ns?
		return self.rectype.to_s.upcase == 'NS'
	end


	def ptr?
		return self.rectype.to_s.upcase == 'PTR'
	end

	def soa?
		return self.rectype.to_s.upcase == 'SOA'
	end


	def txt?
		return self.rectype.to_s.upcase == 'TXT'
	end


	def Record.default_records(domain_name)
		default = Default.instance
		records = []

		# soa record
		records << Record.new(
			:name => "#{domain_name}.",
			:ttl => default.ttl,
			:rectype => 'SOA',
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
				:rectype => 'NS',
				:content => server.fqdn,
				:locked => true
			)
		end

		# mx records
		for server in default.mail_servers
			records << Record.new(
				:name => "#{domain_name}.",
				:ttl => server.ttl,
				:rectype => 'MX',
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
		Validate::Dns.validate_name(mname, errors, :mname)
		Validate::Dns.validate_name(rname, errors, :rname)
		Validate::Dns.validate_serial(serial, errors, :serial)
		Validate::Dns.validate_time(refresh, errors, :refresh)
		Validate::Dns.validate_time(self.retry, errors, :retry)
		Validate::Dns.validate_time(expire, errors, :expire)
		Validate::Dns.validate_time(minimum, errors, :minimum)
	end


	def valid_txt
		Validate::Dns.validate_name(name, errors, :name)
		Validate::Dns.validate_time(ttl, errors, :ttl, true)
		Validate::Dns.validate_no_pref(pref, errors, :pref)
		Validate::Dns.validate_txt(content, errors, :content)
	end

end
