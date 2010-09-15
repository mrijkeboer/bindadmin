require File.expand_path("../../test_helper", __FILE__)

class DefaultTest < ActiveSupport::TestCase

	#
	# ttl
	#
	test "ensure presence of ttl" do
		assert_not_valid_value(Default.new, :ttl, "")
	end


	test "ensure ttl is a valid time" do
		assert_times(Default.new, :ttl)
	end


	#
	# mname
	#
	test "ensure presence of mname" do
		assert_not_valid_value(Default.new, :mname, "")
	end


	test "ensure mname is a valid fqdn" do
		assert_fqdn(Default.new, :mname)
	end


	#
	# rname
	#
	test "ensure presence of rname" do
		assert_not_valid_value(Default.new, :rname, "")
	end


	test "ensure rname is a valid fqdn" do
		assert_fqdn(Default.new, :rname)
	end


	#
	# serial
	#
	test "ensure presence of serial" do
		assert_not_valid_value(Default.new, :serial, "")
	end


	test "ensure valid serial" do
		assert_value_in_range(Default.new, :serial, 1..9999999999)
	end


	#
	# refresh
	#
	test "ensure presence of refresh" do
			assert_not_valid_value(Default.new, :refresh, "")
	end


	test "ensure refresh is a valid time" do
		assert_times(Default.new, :refresh)
	end
	

	#
	# retry
	#
	test "ensure presence of retry" do
			assert_not_valid_value(Default.new, :retry, "")
	end


	test "ensure retry is a valid time" do
		assert_times(Default.new, :retry)
	end


	#
	# expire
	#
	test "ensure presence of expire" do
			assert_not_valid_value(Default.new, :expire, "")
	end


	test "ensure expire is a valid time" do
		assert_times(Default.new, :expire)
	end


	#
	# minimum
	#
	test "ensure presence of minimum" do
			assert_not_valid_value(Default.new, :minimum, "")
	end


	test "ensure minimum is a valid time" do
		assert_times(Default.new, :minimum)
	end

end
