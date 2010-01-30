require File.dirname(__FILE__) + "/../test_helper"
require File.dirname(__FILE__) + "/../factory"

class WelcomeControllerTest < ActionController::TestCase

	#
	# index
	#
	
	test "on GET to :index should redirect to sign_in" do
		get :index
		assert_redirected_to sign_in_path
	end


	#
	# sign_in
	#
	test "on GET to :sign_in should get sign_in page" do
		get :sign_in

		assert_template :sign_in
		assert_response :success
	end


  test "on POST to :sign_in (admin) should redirect to domains" do
    admin = Factory.admin_user!(:password => 'passwd', :password_confirmation => 'passwd')
    post :sign_in, {:username => admin.username, :password => 'passwd'}

    assert_redirected_to admin_domains_path
  end


  test "on POST to :sign_in (owner) should redirect to domains" do
    owner = Factory.owner_user!(:password => 'passwd', :password_confirmation => 'passwd')
    post :sign_in, {:username => owner.username, :password => 'passwd'}

    assert_redirected_to owner_domains_path
  end


  test "on POST to :sign_in with wrong password should redirect to sign_in" do
    user = Factory.user!(:password => 'passwd', :password_confirmation => 'passwd')
    post :sign_in, {:username => user.username, :password => 'wrongpasswd'}

		assert_template :sign_in
		assert_response :success
		assert_equal "Invalid user/password combination", flash[:error]
  end


	#
	# sign_out
	#
	
	test "on GET to :sign_out should redirect to sign_in" do
		get :sign_out

		assert_redirected_to sign_in_path
	end


end
