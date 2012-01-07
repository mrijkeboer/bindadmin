require File.expand_path("../../test_helper", __FILE__)
require File.expand_path("../../factory", __FILE__)

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
		assert domain2.errors[:name].any?
	end


	#
	# domtype
	#
	test "ensure presence of domtype" do
		assert_not_valid_value(Domain.new, :domtype, "")
	end


	test "ensure value of domtype is 'Native' or 'Slave'" do
		assert_valid_value(Domain.new, :domtype, 'Native')
		assert_valid_value(Domain.new, :domtype, 'Slave')
		assert_not_valid_value(Domain.new, :domtype, 'Master')
	end


	#
	# master
	#
	test "ensure presence of master when domtype is 'Slave'" do
		assert_nil_not_valid(Domain.new(:domtype => 'Slave'), :master)
	end


	test "ensure master is a valid domain name when domtype is 'Slave'" do
		assert_domain_name(Domain.new(:domtype => 'Slave'), :master)
	end


	test "ensure non presence of master when domtype is 'Native'" do
		assert_nil_valid(Domain.new(:domtype => 'Native'), :master)
		assert_not_valid_value(Domain.new(:domtype => 'Native'), :master, 'example.com')
	end


	#
	# owner
	#
	test "ensure length of owner within 0..250" do
		assert_length_in_range(Domain.new, :owner, 0..250)
	end


	test "ensure owner is set before saving" do
		domain = Factory.domain
		assert domain.owner.to_s.length == 0
		domain.save
		assert domain.owner.to_s.length > 0
	end


	#
	# native?
	#
	test "ensure native? returns true when domtype is 'Native' and false otherwise" do
		assert Domain.new(:domtype => 'Native').native?
		assert !Domain.new(:domtype => 'Slave').native?
	end


	#
	# slave?
	#
	test "ensure slave? returns true when domtype is 'Slave' and false otherwise" do
		assert Domain.new(:domtype => 'Slave').slave?
		assert !Domain.new(:domtype => 'Native').slave?
	end


	#
	# Domain.changed
	#
	test "ensure working of Domain.changed" do
		Factory.domain!
		assert_equal 1, Domain.changed().count
		assert_equal 0, Domain.changed(Time.now.to_i + 1).count
	end


	#
	# create_records
	#
	test "ensure that a new native domain has a soa record" do
		domain = Factory.domain!(:domtype => 'Native')
		assert domain.records.count > 0
		assert domain.records[0].soa?
	end


	test "ensure that a new slave domain has no records" do
		domain = Factory.domain!(:domtype => 'Slave', :master => 'ns1.example.com')
		assert domain.records.count == 0
	end

end
