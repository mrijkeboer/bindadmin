module RecordFactory

	def RecordFactory.append_features(client)

		def client.record_attributes
			{
				:name => 'www',
				:type => 'A',
				:content => '127.0.0.1',
			}
		end


		def client.record(params = {})
			record = Record.new(Factory.record_attributes.merge(params))
			domain = Factory.domain
			domain.records << record
			record
		end


		def client.record!(params = {})
			obj = Factory.record(params)
			obj.save
			obj
		end

	end

end
