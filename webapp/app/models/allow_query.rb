class AllowQuery
	include MongoMapper::EmbeddedDocument

	# Attributes
	key :name, String
	key :clients, String

	# Validations
	validates_presence_of :name
	validates_length_of :name, :within => 3..250
	validates_presence_of :clients
	validates_length_of :clients, :within => 3..2048


	def domain
		return self._root_document
	end

end
