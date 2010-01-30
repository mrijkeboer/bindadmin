require File.dirname(__FILE__) + "/../test_helper"

class NameServerTest < ActiveSupport::TestCase

	#
	# fqdn
	#
	test "ensure presence of fqdn" do
		assert_nil_not_valid(NameServer.new, :fqdn)
	end


	test "ensure fqdn is a valid fully qualified domain name" do
		assert_fqdn(NameServer.new, :fqdn)
	end


	#
	# ttl
	#
	test "ensure ttl is not mandatory" do
		assert_nil_valid(NameServer.new, :ttl)
	end


	test "ensure ttl is a valid DNS time" do
		assert_times(NameServer.new, :ttl)
	end

end
