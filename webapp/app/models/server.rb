require 'bcrypt'
require 'validate/dns'

class Server
	include MongoMapper::Document

	# Attributes
	key :servername, String
	key :password_hash, String
	timestamps!

	# Validations
	validates_presence_of :servername
	validates_length_of :servername, :within => 3..250
	validates_uniqueness_of :servername
	validates_format_of :servername, :with => /\A(?:[a-z0-9_])+\Z/i
	
	validate :valid_password

	after_save :clear_password
	

	def clear_password
		@password = nil
		@password_confirmation = nil
	end

	
	def servername=(val)
		if self.servername.to_s.length == 0 or self.new_record?
			self[:servername] = val.to_s.downcase
		end
	end
	
	
	def password
		return @password
	end
	
	
	def password=(val)
		if val.present?
			@password = val
			self.password_hash = BCrypt::Password.create(val)
		end
	end
	
	
	def password_confirmation
		return @confirmation
	end
	
	
	def password_confirmation=(val)
		@confirmation = val
	end
	
	
	def correct_password?(password)
		if password_hash == password
			return true
		else
			return false
		end
	end


	def Server.authenticate(servername, password)
		server = Server.find_by_servername(servername.to_s.downcase)
		if server != nil
			if server.correct_password?(password) == false
				server = nil
			end
		end
			
		return server
	end
	
	
	def password_hash
		return BCrypt::Password.new(self[:password_hash])
	end
	
	
	def password_hash=(val)
		self[:password_hash] = val
	end
	
	
	private
	
	
	def valid_password
		if new_record? == true
			if @password.to_s.length == 0
				errors.add(:password, "can't be blank")
			end
		end
		
		if @password.to_s.length > 0
			if @password.to_s.length < 6
				errors.add(:password, "is too short (minimum is 6 characters)")
			elsif @password.to_s.length > 250
				errors.add(:password, "is too long (maximum is 250 characters)")
			end
			
			if @password.to_s != @confirmation.to_s
				errors.add(:password, "doesn't match confirmation")
			end
		end
	end
	
end
