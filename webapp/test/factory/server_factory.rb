module ServerFactory

	def ServerFactory.append_features(client)

		def client.server_attributes
			{ 
				:servername => 'server1',
				:password => 'password',
				:password_confirmation => 'password'
			}
		end


		def client.server(params = {})
			return Server.new(Factory.server_attributes.merge(params))
		end


		def client.server!(params = {})
			obj = Factory.server(params)
			obj.save!
			obj
		end

	end

end
