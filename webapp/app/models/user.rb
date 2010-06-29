require 'bcrypt'

class User
	include MongoMapper::Document
	
	# Attributes
	key :username, String
	key :password_hash, String
	key :fullname, String
	key :role, String, :default => 'Owner'

	timestamps!

	ROLES = [ 'Admin', 'Owner' ]

	# Relationships
	many :domains

	# Validation
	validates_presence_of :username
	validates_length_of :username, :within => 3..250
	validates_uniqueness_of :username

	validates_presence_of :fullname
	validates_length_of :fullname, :within => 3..250

	validates_presence_of :role
	validates_inclusion_of :role, :within => User::ROLES, :message => 'invalid role'

	
	validate :valid_password

	after_save :clear_password
	

	def clear_password
		@password = nil
		@password_confirmation = nil
	end

	
	def username=(val)
		if self.username.to_s.length  == 0 or self.new_record?
			self[:username] = val.to_s.downcase
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


	def admin?
		return self.role.upcase == 'ADMIN'
	end


	def owner?
		return self.role.upcase == 'OWNER'
	end


	def User.authenticate(username, password, role = nil)
		user = User.find_by_username(username.to_s.downcase)
		if user != nil
			if user.correct_password?(password) == false
				user = nil
			end
			
			if user != nil && role != nil
				user = nil unless user.role == role
			end
		end

		return user
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
