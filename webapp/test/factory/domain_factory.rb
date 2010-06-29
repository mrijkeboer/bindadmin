module DomainFactory

	def DomainFactory.append_features(client)

		def client.domain_attributes
			{
				:name => 'example.com',
				:type => 'Native',
				:user => Factory.user
			}
		end


		def client.domain(params = {})
			return Domain.new(Factory.domain_attributes.merge(params))
		end


		def client.domain!(params = {})
			obj = Factory.domain(params)
			obj.save!
			obj
		end

	end

end
