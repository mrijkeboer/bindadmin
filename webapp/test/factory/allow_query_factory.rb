module AllowQueryFactory

	def AllowQueryFactory.append_features(client)

		def client.allow_query_attributes
			{
				:name => 'Internet',
				:clients => 'any;'
			}
		end


		def client.allow_query(params = {})
			allow_query = AllowQuery.new(Factory.allow_query_attributes.merge(params))
			domain = Factory.domain!
			domain.allow_queries << allow_query
			allow_query
		end


		def client.allow_query!(params = {})
			obj = Factory.allow_query(params)
			obj.save
			obj
		end

	end

end
