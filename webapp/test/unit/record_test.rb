require File.expand_path("../../test_helper", __FILE__)

class RecordTest < ActiveSupport::TestCase

	#
	# name
	#
	test "ensure presence of name" do
		assert_nil_not_valid(Record.new(:rectype => 'A'), :name)
		assert_nil_not_valid(Record.new(:rectype => 'AAAA'), :name)
		assert_nil_not_valid(Record.new(:rectype => 'CNAME'), :name)
		assert_nil_not_valid(Record.new(:rectype => 'MX'), :name)
		assert_nil_not_valid(Record.new(:rectype => 'NS'), :name)
		assert_nil_not_valid(Record.new(:rectype => 'PTR'), :name)
		assert_nil_not_valid(Record.new(:rectype => 'SOA'), :name)
		assert_nil_not_valid(Record.new(:rectype => 'TXT'), :name)
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
	# rectype
	#
	test "ensure presence of rectype" do
		assert_nil_not_valid(Record.new, :rectype)
	end


	test "ensure rectype a valid record type" do
		assert_valid_value(Record.new, :rectype, 'A')
		assert_valid_value(Record.new, :rectype, 'AAAA')
		assert_valid_value(Record.new, :rectype, 'CNAME')
		assert_valid_value(Record.new, :rectype, 'MX')
		assert_valid_value(Record.new, :rectype, 'NS')
		assert_valid_value(Record.new, :rectype, 'PTR')
		assert_valid_value(Record.new, :rectype, 'SOA')
		assert_valid_value(Record.new, :rectype, 'TXT')

		assert_valid_value(Record.new, :rectype, 'a')
		assert_valid_value(Record.new, :rectype, 'aaaa')
		assert_valid_value(Record.new, :rectype, 'cname')
		assert_valid_value(Record.new, :rectype, 'mx')
		assert_valid_value(Record.new, :rectype, 'ns')
		assert_valid_value(Record.new, :rectype, 'ptr')
		assert_valid_value(Record.new, :rectype, 'soa')
		assert_valid_value(Record.new, :rectype, 'txt')

		assert_not_valid_value(Record.new, :rectype, 'b')
		assert_not_valid_value(Record.new, :rectype, 'aaa')
		assert_not_valid_value(Record.new, :rectype, 'c')
		assert_not_valid_value(Record.new, :rectype, 2)
	end


	#
	# A record
	#
	test "ensure valid name for A" do
		assert_name(Record.new(:rectype => 'A'), :name)
	end


	test "allow nil for ttl for A" do
		assert_nil_valid(Record.new(:rectype => 'A'), :ttl)
	end


	test "ensure ttl is valid DNS time for A" do
		assert_times(Record.new(:rectype => 'A'), :ttl)
	end


	test "ensure pref is nil for A" do
		assert_nil_valid(Record.new(:rectype => 'A'), :pref)
		assert_not_valid_value(Record.new(:rectype => 'A'), :pref, 100)
	end


	test "ensure content is valid IPv4 address for A" do
		assert_valid_value(Record.new(:rectype => 'A'), :content, '127.0.0.1')
		assert_not_valid_value(Record.new(:rectype => 'A'), :content, '127')
		assert_not_valid_value(Record.new(:rectype => 'A'), :content, '2001::1')
		assert_not_valid_value(Record.new(:rectype => 'A'), :content, 'www')
		assert_not_valid_value(Record.new(:rectype => 'A'), :content, 'www.example.com.')
	end


	test "ensure a? is true" do
		assert Record.new(:rectype => 'A').a?
	end


	#
	# AAAA record
	#
	test "ensure valid name for AAAA" do
		assert_name(Record.new(:rectype => 'AAAA'), :name)
	end


	test "allow nil for ttl for AAAA" do
		assert_nil_valid(Record.new(:rectype => 'AAAA'), :ttl)
	end


	test "ensure ttl is valid DNS time for AAAA" do
		assert_times(Record.new(:rectype => 'AAAA'), :ttl)
	end


	test "ensure pref is nil for AAAA" do
		assert_nil_valid(Record.new(:rectype => 'AAAA'), :pref)
		assert_not_valid_value(Record.new(:rectype => 'AAAA'), :pref, 100)
	end


	test "ensure content is valid IPv6 address for AAAA" do
		assert_valid_value(Record.new(:rectype => 'AAAA'), :content, '2000::1')
		assert_not_valid_value(Record.new(:rectype => 'AAAA'), :content, '127.0.0.1')
		assert_not_valid_value(Record.new(:rectype => 'AAAA'), :content, 'www')
		assert_not_valid_value(Record.new(:rectype => 'AAAA'), :content, 'www.example.com.')
	end


	test "ensure aaaa? is true" do
		assert Record.new(:rectype => 'AAAA').aaaa?
	end


	#
	# CNAME record
	#
	test "ensure valid name for CNAME" do
		assert_name(Record.new(:rectype => 'CNAME'), :name)
	end


	test "allow nil for ttl for CNAME" do
		assert_nil_valid(Record.new(:rectype => 'CNAME'), :ttl)
	end


	test "ensure ttl is valid DNS time for CNAME" do
		assert_times(Record.new(:rectype => 'CNAME'), :ttl)
	end


	test "ensure pref is nil for CNAME" do
		assert_nil_valid(Record.new(:rectype => 'CNAME'), :pref)
		assert_not_valid_value(Record.new(:rectype => 'CNAME'), :pref, 100)
	end


	test "ensure content is valid name for CNAME" do
		assert_name(Record.new(:rectype => 'CNAME'), :content)
	end


	test "ensure cname? is true" do
		assert Record.new(:rectype => 'CNAME').cname?
	end


	#
	# MX record
	#
	test "ensure valid name for MX" do
		assert_name(Record.new(:rectype => 'MX'), :name)
	end


	test "allow nil for ttl for MX" do
		assert_nil_valid(Record.new(:rectype => 'MX'), :ttl)
	end


	test "ensure ttl is valid DNS time for MX" do
		assert_times(Record.new(:rectype => 'MX'), :ttl)
	end


	test "ensure presence of pref for MX" do
		assert_nil_not_valid(Record.new(:rectype => 'MX'), :pref)
	end


	test "ensure valid value of pref for MX" do
		assert_value_in_range(Record.new(:rectype => 'MX'), :pref, 1..9999)
		assert_not_valid_value(Record.new(:rectype => 'MX'), :pref, 4.5)
		assert_not_valid_value(Record.new(:rectype => 'MX'), :pref, -10)
		assert_not_valid_value(Record.new(:rectype => 'MX'), :pref, 'a')
	end


	test "ensure content is valid name for MX" do
		assert_name(Record.new(:rectype => 'MX'), :content)
	end


	test "ensure mx? is true" do
		assert Record.new(:rectype => 'MX').mx?
	end


	#
	# NS record
	#
	test "ensure valid name for NS" do
		assert_name(Record.new(:rectype => 'NS'), :name)
	end


	test "allow nil for ttl for NS" do
		assert_nil_valid(Record.new(:rectype => 'NS'), :ttl)
	end


	test "ensure ttl is valid DNS time for NS" do
		assert_times(Record.new(:rectype => 'NS'), :ttl)
	end


	test "ensure pref is nil for NS" do
		assert_nil_valid(Record.new(:rectype => 'NS'), :pref)
		assert_not_valid_value(Record.new(:rectype => 'NS'), :pref, 100)
	end


	test "ensure content is valid IPv4 address for NS" do
		assert_name(Record.new(:rectype => 'NS'), :content)
	end


	test "ensure ns? is true" do
		assert Record.new(:rectype => 'NS').ns?
	end


	#
	# PTR record
	#
	test "ensure valid name for PTR" do
		assert_name(Record.new(:rectype => 'PTR'), :name)
	end


	test "allow nil for ttl for PTR" do
		assert_nil_valid(Record.new(:rectype => 'PTR'), :ttl)
	end


	test "ensure ttl is valid DNS time for PTR" do
		assert_times(Record.new(:rectype => 'PTR'), :ttl)
	end


	test "ensure pref is nil for PTR" do
		assert_nil_valid(Record.new(:rectype => 'PTR'), :pref)
		assert_not_valid_value(Record.new(:rectype => 'PTR'), :pref, 100)
	end


	test "ensure content is valid name for PTR" do
		assert_name(Record.new(:rectype => 'PTR'), :content)
	end


	test "ensure ptr? is true" do
		assert Record.new(:rectype => 'PTR').ptr?
	end


	#
	# SOA record
	#
	test "ensure valid name for SOA" do
		assert_name(Record.new(:rectype => 'SOA'), :name)
	end


	test "ensure presence of ttl for SOA" do
		assert_nil_not_valid(Record.new(:rectype => 'SOA'), :ttl)
	end


	test "ensure ttl is valid DNS time for SOA" do
		assert_times(Record.new(:rectype => 'SOA'), :ttl)
	end


	test "ensure pref is nil for SOA" do
		assert_nil_valid(Record.new(:rectype => 'SOA'), :pref)
		assert_not_valid_value(Record.new(:rectype => 'SOA'), :pref, 100)
	end


	test "ensure presence of mname for SOA" do
		assert_nil_not_valid(Record.new(:rectype => 'SOA'), :mname)
	end


	test "ensure mname is valid name for SOA" do
		assert_name(Record.new(:rectype => 'SOA'), :mname)
	end


	test "ensure presence of rname for SOA" do
		assert_nil_not_valid(Record.new(:rectype => 'SOA'), :rname)
	end


	test "ensure rname is valid name for SOA" do
		assert_name(Record.new(:rectype => 'SOA'), :rname)
	end


	test "ensure presence of serial for SOA" do
		assert_nil_not_valid(Record.new(:rectype => 'SOA'), :serial)
	end


	test "ensure serial is valid number for SOA" do
		assert_value_in_range(Record.new(:rectype => 'SOA'), :serial, 1..9999999999)
		#assert_not_valid_value(Record.new(:rectype => 'SOA'), :serial, -10)
		#assert_not_valid_value(Record.new(:rectype => 'SOA'), :serial, 'a')
		#assert_not_valid_value(Record.new(:rectype => 'SOA'), :serial, '-')
	end


	test "ensure presence of refresh for SOA" do
		assert_nil_not_valid(Record.new(:rectype => 'SOA'), :refresh)
	end


	test "ensure refresh is valid DNS time for SOA" do
		assert_times(Record.new(:rectype => 'SOA'), :refresh)
	end


	test "ensure presence of retry for SOA" do
		assert_nil_not_valid(Record.new(:rectype => 'SOA'), :retry)
	end


	test "ensure retry is valid DNS time for SOA" do
		assert_times(Record.new(:rectype => 'SOA'), :retry)
	end


	test "ensure presence of expire for SOA" do
		assert_nil_not_valid(Record.new(:rectype => 'SOA'), :expire)
	end


	test "ensure expire is valid DNS time for SOA" do
		assert_times(Record.new(:rectype => 'SOA'), :expire)
	end


	test "ensure presence of minimum for SOA" do
		assert_nil_not_valid(Record.new(:rectype => 'SOA'), :minimum)
	end


	test "ensure minimum is valid DNS time for SOA" do
		assert_times(Record.new(:rectype => 'SOA'), :minimum)
	end


	test "ensure content contains all the information" do
		record = Record.new(
			:rectype => 'SOA',
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
		assert Record.new(:rectype => 'SOA').soa?
	end


	test "ensure locked is always true for SOA" do
		assert Record.new(:rectype => 'SOA').locked
		assert Record.new(:rectype => 'SOA', :locked => false).locked
	end


	#
	# TXT record
	#
	test "ensure valid name for TXT" do
		assert_name(Record.new(:rectype => 'TXT'), :name)
	end


	test "allow nil for ttl for TXT" do
		assert_nil_valid(Record.new(:rectype => 'TXT'), :ttl)
	end


	test "ensure ttl is valid DNS time for TXT" do
		assert_times(Record.new(:rectype => 'TXT'), :ttl)
	end


	test "ensure pref is nil for TXT" do
		assert_nil_valid(Record.new(:rectype => 'TXT'), :pref)
		assert_not_valid_value(Record.new(:rectype => 'TXT'), :pref, 100)
	end


	test "ensure content is valid text for TXT" do
		assert_length_in_range(Record.new(:rectype => 'TXT'), :content, 1..250)
		assert_valid_value(Record.new(:rectype => 'TXT'), :content, 'Foo bar')
	end


	test "ensure txt? is true" do
		assert Record.new(:rectype => 'TXT').txt?
	end


end
