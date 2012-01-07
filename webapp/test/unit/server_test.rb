require File.expand_path("../../test_helper", __FILE__)
require File.expand_path("../../factory", __FILE__)

class ServerTest < ActiveSupport::TestCase

	#
	# servername
	#
	test "ensure presence of servername" do
		assert_nil_not_valid(Server.new, :servername)
	end


	test "ensure length of servername in 3..250" do
		assert_length_in_range(Server.new, :servername, 3..250)
	end


	test "ensure servername is unique" do
		server1 = Factory.server!
		server2 = Factory.server
		assert !server2.valid?
		assert server2.errors[:servername].any?
	end


	test "validate immutability of servername" do
		server = Factory.server!(:servername => 'test')
		server.servername = 'changed'
		assert_equal 'test', server.servername
	end                                               


	#
	# password
	#
	test "ensure presence of password" do
		assert_nil_not_valid(Server.new, :password)
	end


	test "ensure length of password in 6..250" do
		server = Server.new                      
		server.password = 'x' * 5              
		server.password_confirmation = 'x' * 5 
		server.valid?                          
		assert server.errors[:password].any?

		server.password = 'x' * 6
		server.password_confirmation = 'x' * 6
		server.valid?                         
		assert !server.errors[:password].any?

		server.password = 'x' * 250
		server.password_confirmation = 'x' * 250
		server.valid?                           
		assert !server.errors[:password].any?

		server.password = 'x' * 251
		server.valid?              
		assert server.errors[:password].any?
	end


	test "ensure password and confirmation match" do
		password = 'password'                               
		server = Server.new(:password_confirmation => password) 

		server.password = password
		server.valid?             
		assert !server.errors[:password].any?

		server.password = 'wrongpassword'
		server.valid?                    
		assert server.errors[:password].any?
	end


	#
	# correct_password?
	#                  
	test "ensure working of correct_password?" do
		password = 'password'
		server = Server.new(:password => password, :password_confirmation => password)

		assert server.correct_password?(password)
		assert !server.correct_password?('wrongpassword')
	end


	#
	# Server.authenticate
	#
	test "validate the working of Server.authenticate" do
		server = Factory.server!(:password => 'passwd', :password_confirmation => 'passwd')
		assert_not_nil Server.authenticate(server.servername, 'passwd')
		assert_nil Server.authenticate(server.servername, 'wrongpasswd')
	end

end
