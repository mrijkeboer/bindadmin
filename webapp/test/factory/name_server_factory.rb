module NameServerFactory

	def NameServerFactory.append_features(client)

		def client.name_server_attributes
			{ 
				:fqdn => 'ns1.example.com.'
			}
		end


		def client.name_server(params = {})
			name_server = NameServer.new(Factory.name_server_attributes.merge(params))
			default = Factory.default
			default.name_servers << name_server
			name_server
		end


		def client.name_server!(params = {})
			obj = Factory.name_server(params)
			obj.save
			obj
		end

	end
end
