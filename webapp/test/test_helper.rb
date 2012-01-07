ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
	
	def assert_value_in_range(object, attribute, range)
		assert_not_valid_value(object, attribute, range.first - 1)
		assert_valid_value(object, attribute, range.first)
		assert_valid_value(object, attribute, range.last)
		assert_not_valid_value(object, attribute, range.last + 1)
	end


	def assert_length_in_range(object, attribute, range)
		if range.first >= 1
			assert_length_not_valid(object, attribute, range.first - 1)
		end
		assert_length_valid(object, attribute, range.first)
		assert_length_valid(object, attribute, range.last)
		assert_length_not_valid(object, attribute, range.last + 1)
	end


	def assert_times(object, attribute)
		assert_valid_value(object, attribute, 1)
		assert_valid_value(object, attribute, '2s')
		assert_valid_value(object, attribute, '3m')
		assert_valid_value(object, attribute, '4h')
		assert_valid_value(object, attribute, '5d')
		assert_valid_value(object, attribute, '6w')
		assert_not_valid_value(object, attribute, '1z')
		assert_not_valid_value(object, attribute, 's')
		assert_not_valid_value(object, attribute, 'm')
		assert_not_valid_value(object, attribute, 'h')
		assert_not_valid_value(object, attribute, 'd')
		assert_not_valid_value(object, attribute, 'w')
		assert_not_valid_value(object, attribute, '3m2s')
	end


	def assert_name(object, attribute)
		assert_valid_value(object, attribute, 'www')
		assert_valid_value(object, attribute, 'www.example.com.')
		assert_valid_value(object, attribute, 'nl.www')
		assert_valid_value(object, attribute, 'nl.www.example.com.')
		assert_valid_value(object, attribute, 2)
		assert_valid_value(object, attribute, '2.0.0.127.in-addr.arpa.')
		assert_valid_value(object, attribute, 'test-2')
		assert_valid_value(object, attribute, 'test-2.example.com.')
		assert_not_valid_value(object, attribute, '-www')
		assert_not_valid_value(object, attribute, 'www-')
		assert_not_valid_value(object, attribute, 'www!')
		assert_not_valid_value(object, attribute, 'www@')
		assert_not_valid_value(object, attribute, 'www#')
		assert_not_valid_value(object, attribute, 'www$')
		assert_not_valid_value(object, attribute, 'www%')
		assert_not_valid_value(object, attribute, 'www^')
		assert_not_valid_value(object, attribute, 'www&')
		assert_not_valid_value(object, attribute, 'www*')
		assert_not_valid_value(object, attribute, 'www_')
		assert_not_valid_value(object, attribute, 'www+')
		assert_not_valid_value(object, attribute, 'www=')
		assert_not_valid_value(object, attribute, '127.0.0.1')
		assert_not_valid_value(object, attribute, '2001::1')
	end


	def assert_fqdn(object, attribute)
		assert_valid_value(object, attribute, 'example.com.')
		assert_valid_value(object, attribute, 'ns1.example.com.')
		assert_valid_value(object, attribute, 'root.example.com.')
		assert_valid_value(object, attribute, 'n.nl.')
		assert_not_valid_value(object, attribute, 'com')
		assert_not_valid_value(object, attribute, 'com.')
		assert_not_valid_value(object, attribute, 'example.com')
		assert_not_valid_value(object, attribute, 'test_example.com.')
	end


	def assert_domain_name(object, attribute)
		assert_valid_value(object, attribute, 'n.nl')
		assert_valid_value(object, attribute, 'example.com')
		assert_valid_value(object, attribute, 'test.example.com')
		assert_valid_value(object, attribute, ('x' * 246) +  '.com')
		assert_not_valid_value(object, attribute, ('x' * 247) + '.com')
		assert_not_valid_value(object, attribute, 'example.com.')
		assert_not_valid_value(object, attribute, 'test.example.com.')
		assert_not_valid_value(object, attribute, '.example.com.')
		assert_not_valid_value(object, attribute, 'test_example.com')
	end


	def assert_length_valid(object, attribute, length)
		assert_valid_value(object, attribute, 'x' * length)
	end


	def assert_length_not_valid(object, attribute, length)
		assert_not_valid_value(object, attribute, 'x' * length)
	end


	def assert_nil_not_valid(object, attribute)
		object.send("#{attribute}=", nil)
		object.valid?
		assert_block "<#{attribute}> expected to be invalid when set to <nil>" do
			object.errors[attribute].any?
		end
	end


	def assert_nil_valid(object, attribute)
		object.send("#{attribute}=", nil)
		object.valid?
		assert_block "<#{attribute}> expected to be valid when set to <nil>" do
			!object.errors[attribute].any?
		end
	end


	def assert_valid_value(object, attribute, value)
		object.send("#{attribute}=", value)
		object.valid?
		assert_block "<#{attribute}> expected to be valid when set to <#{value}>" do
			!object.errors[attribute].any?
		end
	end


	def assert_not_valid_value(object, attribute, value)
		object.send("#{attribute}=", value)
		object.valid?
		assert_block "<#{attribute}> expected to be invalid when set to <#{value}>" do
			object.errors[attribute].any?
		end
	end


end
