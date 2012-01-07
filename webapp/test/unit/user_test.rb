require File.expand_path("../../test_helper", __FILE__)
require File.expand_path("../../factory", __FILE__)

class UserTest < ActiveSupport::TestCase
	
	#
	# username
	#
	test "ensure presence of username" do
		assert_nil_not_valid(User.new, :username)
	end


	test "ensure uniqueness of username" do
		user1 = Factory.user!
		user2 = Factory.user
		assert !user2.valid?
		assert user2.errors[:username].any?
	end


	test "ensure length of username in 3..250" do
		assert_length_in_range(User.new, :username, 3..250)
	end


	test "validate immutability of username" do
		user = Factory.user!(:username => 'test')
		user.username = 'changed'
		assert_equal 'test', user.username
	end                                               


	#
	# fullname
	#
	test "ensure presence of fullname" do
		assert_nil_not_valid(User.new, :fullname)
	end


	test "ensure length of fullname in 3..250" do
		assert_length_in_range(User.new, :fullname, 3..250)
	end


	#
	# role
	#
  test "ensure presence of role" do
		assert_not_valid_value(User.new, :role, "")
	end


	test "ensure value of role is 'Admin' or 'Owner'" do
		assert_valid_value(User.new, :role, 'Admin')
		assert_valid_value(User.new, :role, 'Owner')
		assert_not_valid_value(User.new, :role, 'User')
	end


	#
	# password
	#
	test "ensure presence of password" do
		assert_nil_not_valid(User.new, :password)
	end                                           


	test "ensure length of password in 6..250" do
		user = User.new                      
		user.password = 'x' * 5              
		user.password_confirmation = 'x' * 5 
		user.valid?                          
		assert user.errors[:password].any?

		user.password = 'x' * 6
		user.password_confirmation = 'x' * 6
		user.valid?                         
		assert !user.errors[:password].any?

		user.password = 'x' * 250
		user.password_confirmation = 'x' * 250
		user.valid?                           
		assert !user.errors[:password].any?

		user.password = 'x' * 251
		user.valid?              
		assert user.errors[:password].any?
	end                                           


	test "ensure password and confirmation match" do
		password = 'password'                               
		user = User.new(:password_confirmation => password) 

		user.password = password
		user.valid?             
		assert !user.errors[:password].any?

		user.password = 'wrongpassword'
		user.valid?                    
		assert user.errors[:password].any?
	end                                           


	#
	# correct_password?
	#                  
	test "ensure working of correct_password?" do
		password = 'password'
		user = User.new(:password => password, :password_confirmation => password)

		assert user.correct_password?(password)
		assert !user.correct_password?('wrongpassword')
	end


	#
	# admin?
	#
	test "ensure working of admin?" do
		assert User.new(:role => 'Admin').admin?
		assert !User.new(:role => 'Owner').admin?
	end


	#
	# owner?
	#
	test "ensure working of owner?" do
		assert User.new(:role => 'Owner').owner?
		assert !User.new(:role => 'Admin').owner?
	end


	#
	# User.authenticate
	#
	test "Ensure working of User.authenticate" do
		user = Factory.user!(:password => 'passwd', :password_confirmation => 'passwd')
		assert_not_nil User.authenticate(user.username, 'passwd')
		assert_nil User.authenticate(user.username, 'wrongpasswd')
	end

end
