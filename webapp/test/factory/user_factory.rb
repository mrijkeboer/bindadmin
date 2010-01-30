module UserFactory

	def UserFactory.append_features(client)

		def client.user_attributes
			{ 
				:username => 'user',
				:password => 'password',
				:password_confirmation => 'password',
				:fullname => 'User Account',
				:role => 'Owner'
			}
		end


		def client.user(params = {})
			return User.new(Factory.user_attributes.merge(params))
		end


		def client.user!(params = {})
			obj = Factory.user(params)
			obj.save!
			obj
		end


		def client.admin_user(params = {})
			values = {:username => 'admin', :role => 'Admin'}.merge(params)
			return self.user(values)
		end


		def client.admin_user!(params = {})
			obj = Factory.admin_user(params)
			obj.save!
			obj
		end


		def client.owner_user(params = {})
			values = {:username => 'owner', :role => 'Owner'}.merge(params)
			return self.user(values)
		end


		def client.owner_user!(params = {})
			obj = Factory.owner_user(params)
			obj.save!
			obj
		end

	end

end
