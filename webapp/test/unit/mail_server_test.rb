require File.expand_path("../../test_helper", __FILE__)

class MailServerTest < ActiveSupport::TestCase

	#
	# fqdn
	#
	test "ensure presence of fqdn" do
		assert_nil_not_valid(MailServer.new, :fqdn)
	end


	test "ensure fqdn is a valid fully qualified domain name" do
		assert_fqdn(MailServer.new, :fqdn)
	end


	#
	# ttl
	#
	test "ensure ttl is not mandatory" do
		assert_nil_valid(MailServer.new, :ttl)
	end


	test "ensure ttl is a valid DNS time" do
		assert_times(MailServer.new, :ttl)
	end


	#
	# pref
	#
	test "ensure presence of pref" do
		assert_nil_not_valid(MailServer.new, :pref)
	end


	test "ensure pref is a valid number" do
		assert_value_in_range(MailServer.new, :pref, 1..9999)
		assert_not_valid_value(MailServer.new, :pref, 'a')
		assert_not_valid_value(MailServer.new, :pref, 4.5)
		assert_not_valid_value(MailServer.new, :pref, -10)
	end

end
