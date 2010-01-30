require File.dirname(__FILE__) + "/../test_helper"
require File.dirname(__FILE__) + "/../factory"

class DomainTest < ActiveSupport::TestCase

	#
	# user
	#
	test "ensure presence of user" do
		assert_nil_not_valid(Domain.new, :user)
	end


	#
	# name
	#
	test "ensure presence of name" do
		assert_nil_not_valid(Domain.new, :name)
	end


	test "ensure name is a valid domain name" do
		assert_domain_name(Domain.new, :name)
	end


	test "ensure name is unique" do
		domain1 = Factory.domain!
		domain2 = Factory.domain
		assert !domain2.valid?
		assert domain2.errors.invalid?(:name)
	end


	#
	# type
	#
	test "ensure presence of type" do
		assert_not_valid_value(Domain.new, :type, "")
	end


	test "ensure value of type is 'Native' or 'Slave'" do
		assert_valid_value(Domain.new, :type, 'Native')
		assert_valid_value(Domain.new, :type, 'Slave')
		assert_not_valid_value(Domain.new, :type, 'Master')
	end


	#
	# master
	#
	test "ensure presence of master when type is 'Slave'" do
		assert_nil_not_valid(Domain.new(:type => 'Slave'), :master)
	end


	test "ensure master is a valid domain name when type is 'Slave'" do
		assert_domain_name(Domain.new(:type => 'Slave'), :master)
	end


	test "ensure non presence of master when type is 'Native'" do
		assert_nil_valid(Domain.new(:type => 'Native'), :master)
		assert_not_valid_value(Domain.new(:type => 'Native'), :master, 'example.com')
	end


	#
	# owner
	#
	test "ensure length of owner within 0..250" do
		assert_length_in_range(Domain.new, :owner, 0..250)
	end


	#
	# native?
	#
	test "ensure native? returns true when type is 'Native' and false otherwise" do
		assert Domain.new(:type => 'Native').native?
		assert !Domain.new(:type => 'Slave').native?
	end


	#
	# slave?
	#
	test "ensure slave? returns true when type is 'Slave' and false otherwise" do
		assert Domain.new(:type => 'Slave').slave?
		assert !Domain.new(:type => 'Native').slave?
	end


	#
	# Domain.changed
	#
	test "ensure working of Domain.changed" do
		Factory.domain!
		assert_equal 1, Domain.changed().count
		assert_equal 0, Domain.changed(Time.now.to_i).count
	end

end
