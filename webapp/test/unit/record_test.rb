require File.expand_path("../../test_helper", __FILE__)

class RecordTest < ActiveSupport::TestCase

	#
	# name
	#
	test "ensure presence of name" do
		assert_nil_not_valid(Record.new(:type => 'A'), :name)
		assert_nil_not_valid(Record.new(:type => 'AAAA'), :name)
		assert_nil_not_valid(Record.new(:type => 'CNAME'), :name)
		assert_nil_not_valid(Record.new(:type => 'MX'), :name)
		assert_nil_not_valid(Record.new(:type => 'NS'), :name)
		assert_nil_not_valid(Record.new(:type => 'PTR'), :name)
		assert_nil_not_valid(Record.new(:type => 'SOA'), :name)
		assert_nil_not_valid(Record.new(:type => 'TXT'), :name)
	end


	#
	# recclass
	#
	test "ensure recclass is always 'IN'" do
		record = Record.new
		record.recclass = nil
		assert_equal 'IN', record.recclass

		record.recclass = 'TEST'
		assert_equal 'IN', record.recclass

		record.recclass = 1234
		assert_equal 'IN', record.recclass
	end


	#
	# type
	#
	test "ensure presence of type" do
		assert_nil_not_valid(Record.new, :type)
	end


	test "ensure type a valid domain type" do
		assert_valid_value(Record.new, :type, 'A')
		assert_valid_value(Record.new, :type, 'AAAA')
		assert_valid_value(Record.new, :type, 'CNAME')
		assert_valid_value(Record.new, :type, 'MX')
		assert_valid_value(Record.new, :type, 'NS')
		assert_valid_value(Record.new, :type, 'PTR')
		assert_valid_value(Record.new, :type, 'SOA')
		assert_valid_value(Record.new, :type, 'TXT')

		assert_valid_value(Record.new, :type, 'a')
		assert_valid_value(Record.new, :type, 'aaaa')
		assert_valid_value(Record.new, :type, 'cname')
		assert_valid_value(Record.new, :type, 'mx')
		assert_valid_value(Record.new, :type, 'ns')
		assert_valid_value(Record.new, :type, 'ptr')
		assert_valid_value(Record.new, :type, 'soa')
		assert_valid_value(Record.new, :type, 'txt')

		assert_not_valid_value(Record.new, :type, 'b')
		assert_not_valid_value(Record.new, :type, 'aaa')
		assert_not_valid_value(Record.new, :type, 'c')
		assert_not_valid_value(Record.new, :type, 2)
	end


	#
	# A record
	#
	test "ensure valid name for A" do
		assert_name(Record.new(:type => 'A'), :name)
	end


	test "allow nil for ttl for A" do
		assert_nil_valid(Record.new(:type => 'A'), :ttl)
	end


	test "ensure ttl is valid DNS time for A" do
		assert_times(Record.new(:type => 'A'), :ttl)
	end


	test "ensure pref is nil for A" do
		assert_nil_valid(Record.new(:type => 'A'), :pref)
		assert_not_valid_value(Record.new(:type => 'A'), :pref, 100)
	end


	test "ensure content is valid IPv4 address for A" do
		assert_valid_value(Record.new(:type => 'A'), :content, '127.0.0.1')
		assert_not_valid_value(Record.new(:type => 'A'), :content, '127')
		assert_not_valid_value(Record.new(:type => 'A'), :content, '2001::1')
		assert_not_valid_value(Record.new(:type => 'A'), :content, 'www')
		assert_not_valid_value(Record.new(:type => 'A'), :content, 'www.example.com.')
	end


	test "ensure a? is true" do
		assert Record.new(:type => 'A').a?
	end


	#
	# AAAA record
	#
	test "ensure valid name for AAAA" do
		assert_name(Record.new(:type => 'AAAA'), :name)
	end


	test "allow nil for ttl for AAAA" do
		assert_nil_valid(Record.new(:type => 'AAAA'), :ttl)
	end


	test "ensure ttl is valid DNS time for AAAA" do
		assert_times(Record.new(:type => 'AAAA'), :ttl)
	end


	test "ensure pref is nil for AAAA" do
		assert_nil_valid(Record.new(:type => 'AAAA'), :pref)
		assert_not_valid_value(Record.new(:type => 'AAAA'), :pref, 100)
	end


	test "ensure content is valid IPv6 address for AAAA" do
		assert_valid_value(Record.new(:type => 'AAAA'), :content, '2000::1')
		assert_not_valid_value(Record.new(:type => 'AAAA'), :content, '127.0.0.1')
		assert_not_valid_value(Record.new(:type => 'AAAA'), :content, 'www')
		assert_not_valid_value(Record.new(:type => 'AAAA'), :content, 'www.example.com.')
	end


	test "ensure aaaa? is true" do
		assert Record.new(:type => 'AAAA').aaaa?
	end


	#
	# CNAME record
	#
	test "ensure valid name for CNAME" do
		assert_name(Record.new(:type => 'CNAME'), :name)
	end


	test "allow nil for ttl for CNAME" do
		assert_nil_valid(Record.new(:type => 'CNAME'), :ttl)
	end


	test "ensure ttl is valid DNS time for CNAME" do
		assert_times(Record.new(:type => 'CNAME'), :ttl)
	end


	test "ensure pref is nil for CNAME" do
		assert_nil_valid(Record.new(:type => 'CNAME'), :pref)
		assert_not_valid_value(Record.new(:type => 'CNAME'), :pref, 100)
	end


	test "ensure content is valid name for CNAME" do
		assert_name(Record.new(:type => 'CNAME'), :content)
	end


	test "ensure cname? is true" do
		assert Record.new(:type => 'CNAME').cname?
	end


	#
	# MX record
	#
	test "ensure valid name for MX" do
		assert_name(Record.new(:type => 'MX'), :name)
	end


	test "allow nil for ttl for MX" do
		assert_nil_valid(Record.new(:type => 'MX'), :ttl)
	end


	test "ensure ttl is valid DNS time for MX" do
		assert_times(Record.new(:type => 'MX'), :ttl)
	end


	test "ensure presence of pref for MX" do
		assert_nil_not_valid(Record.new(:type => 'MX'), :pref)
	end


	test "ensure valid value of pref for MX" do
		assert_value_in_range(Record.new(:type => 'MX'), :pref, 1..9999)
		assert_not_valid_value(Record.new(:type => 'MX'), :pref, 4.5)
		assert_not_valid_value(Record.new(:type => 'MX'), :pref, -10)
		assert_not_valid_value(Record.new(:type => 'MX'), :pref, 'a')
	end


	test "ensure content is valid name for MX" do
		assert_name(Record.new(:type => 'MX'), :content)
	end


	test "ensure mx? is true" do
		assert Record.new(:type => 'MX').mx?
	end


	#
	# NS record
	#
	test "ensure valid name for NS" do
		assert_name(Record.new(:type => 'NS'), :name)
	end


	test "allow nil for ttl for NS" do
		assert_nil_valid(Record.new(:type => 'NS'), :ttl)
	end


	test "ensure ttl is valid DNS time for NS" do
		assert_times(Record.new(:type => 'NS'), :ttl)
	end


	test "ensure pref is nil for NS" do
		assert_nil_valid(Record.new(:type => 'NS'), :pref)
		assert_not_valid_value(Record.new(:type => 'NS'), :pref, 100)
	end


	test "ensure content is valid IPv4 address for NS" do
		assert_name(Record.new(:type => 'NS'), :content)
	end


	test "ensure ns? is true" do
		assert Record.new(:type => 'NS').ns?
	end


	#
	# PTR record
	#
	test "ensure valid name for PTR" do
		assert_name(Record.new(:type => 'PTR'), :name)
	end


	test "allow nil for ttl for PTR" do
		assert_nil_valid(Record.new(:type => 'PTR'), :ttl)
	end


	test "ensure ttl is valid DNS time for PTR" do
		assert_times(Record.new(:type => 'PTR'), :ttl)
	end


	test "ensure pref is nil for PTR" do
		assert_nil_valid(Record.new(:type => 'PTR'), :pref)
		assert_not_valid_value(Record.new(:type => 'PTR'), :pref, 100)
	end


	test "ensure content is valid name for PTR" do
		assert_name(Record.new(:type => 'PTR'), :content)
	end


	test "ensure ptr? is true" do
		assert Record.new(:type => 'PTR').ptr?
	end


	#
	# SOA record
	#
	test "ensure valid name for SOA" do
		assert_name(Record.new(:type => 'SOA'), :name)
	end


	test "ensure presence of ttl for SOA" do
		assert_nil_not_valid(Record.new(:type => 'SOA'), :ttl)
	end


	test "ensure ttl is valid DNS time for SOA" do
		assert_times(Record.new(:type => 'SOA'), :ttl)
	end


	test "ensure pref is nil for SOA" do
		assert_nil_valid(Record.new(:type => 'SOA'), :pref)
		assert_not_valid_value(Record.new(:type => 'SOA'), :pref, 100)
	end


	test "ensure presence of mname for SOA" do
		assert_nil_not_valid(Record.new(:type => 'SOA'), :mname)
	end


	test "ensure mname is valid name for SOA" do
		assert_name(Record.new(:type => 'SOA'), :mname)
	end


	test "ensure presence of rname for SOA" do
		assert_nil_not_valid(Record.new(:type => 'SOA'), :rname)
	end


	test "ensure rname is valid name for SOA" do
		assert_name(Record.new(:type => 'SOA'), :rname)
	end


	test "ensure presence of serial for SOA" do
		assert_nil_not_valid(Record.new(:type => 'SOA'), :serial)
	end


	test "ensure serial is valid number for SOA" do
		assert_value_in_range(Record.new(:type => 'SOA'), :serial, 1..9999999999)
		assert_not_valid_value(Record.new(:type => 'SOA'), :serial, -10)
		assert_not_valid_value(Record.new(:type => 'SOA'), :serial, 'a')
		assert_not_valid_value(Record.new(:type => 'SOA'), :serial, '-')
	end


	test "ensure presence of refresh for SOA" do
		assert_nil_not_valid(Record.new(:type => 'SOA'), :refresh)
	end


	test "ensure refresh is valid DNS time for SOA" do
		assert_times(Record.new(:type => 'SOA'), :refresh)
	end


	test "ensure presence of retry for SOA" do
		assert_nil_not_valid(Record.new(:type => 'SOA'), :retry)
	end


	test "ensure retry is valid DNS time for SOA" do
		assert_times(Record.new(:type => 'SOA'), :retry)
	end


	test "ensure presence of expire for SOA" do
		assert_nil_not_valid(Record.new(:type => 'SOA'), :expire)
	end


	test "ensure expire is valid DNS time for SOA" do
		assert_times(Record.new(:type => 'SOA'), :expire)
	end


	test "ensure presence of minimum for SOA" do
		assert_nil_not_valid(Record.new(:type => 'SOA'), :minimum)
	end


	test "ensure minimum is valid DNS time for SOA" do
		assert_times(Record.new(:type => 'SOA'), :minimum)
	end


	test "ensure content contains all the information" do
		record = Record.new(
			:type => 'SOA',
			:mname => 'ns1.example.com.',
			:rname => 'root.example.com.',
			:serial => 1,
			:refresh => '1h',
			:retry => '10m',
			:expire => '41d',
			:minimum => '1h'
		)
		content = 'ns1.example.com. root.example.com. 1 1h 10m 41d 1h'
		assert_equal(content, record.content)
	end


	test "ensure soa? is true" do
		assert Record.new(:type => 'SOA').soa?
	end


	test "ensure locked is always true for SOA" do
		assert Record.new(:type => 'SOA').locked
		assert Record.new(:type => 'SOA', :locked => false).locked
	end


	#
	# TXT record
	#
	test "ensure valid name for TXT" do
		assert_name(Record.new(:type => 'TXT'), :name)
	end


	test "allow nil for ttl for TXT" do
		assert_nil_valid(Record.new(:type => 'TXT'), :ttl)
	end


	test "ensure ttl is valid DNS time for TXT" do
		assert_times(Record.new(:type => 'TXT'), :ttl)
	end


	test "ensure pref is nil for TXT" do
		assert_nil_valid(Record.new(:type => 'TXT'), :pref)
		assert_not_valid_value(Record.new(:type => 'TXT'), :pref, 100)
	end


	test "ensure content is valid text for TXT" do
		assert_length_in_range(Record.new(:type => 'TXT'), :content, 1..250)
		assert_valid_value(Record.new(:type => 'TXT'), :content, 'Foo bar')
	end


	test "ensure txt? is true" do
		assert Record.new(:type => 'TXT').txt?
	end


end
