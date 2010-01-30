module DefaultFactory

	def DefaultFactory.append_features(client)

		def client.default_attributes
			{ }
		end


		def client.default(params = {})
			return Default.new(Factory.default_attributes.merge(params))

		end


		def client.default!(params = {})
			obj = Factory.default(params)
			obj.save!
			obj
		end

	end

end
