module MailServerFactory

	def MailServerFactory.append_features(client)

		def client.mail_server_attributes
			{ 
				:fqdn => 'mx1.example.com.',
				:pref => 10
			}
		end


		def client.mail_server(params = {})
			mail_server = MailServer.new(Factory.mail_server_attributes.merge(params))
			default = Factory.default!
			default.mail_servers << mail_server
			mail_server
		end


		def client.mail_server!(params = {})
			obj = Factory.mail_server(params)
			obj.save
			obj
		end

	end
end
