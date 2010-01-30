require File.dirname(__FILE__) + "/../test_helper"

class AllowQueryTest < ActiveSupport::TestCase

	#
	# name
	#
	test "ensure presence of name" do
		assert_nil_not_valid(AllowQuery.new, :name)
	end


	test "ensure length of name within 3..250" do
		assert_length_in_range(AllowQuery.new, :name, 3..250)
	end
	

	#
	# clients
	#
	test "ensure presence of clients" do
		assert_nil_not_valid(AllowQuery.new, :clients)
	end


	test "ensure length of clients within 3..2048" do
		assert_length_in_range(AllowQuery.new, :clients, 3..2048)
	end

end
