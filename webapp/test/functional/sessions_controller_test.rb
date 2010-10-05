require File.expand_path("../../test_helper", __FILE__)
require File.expand_path("../../factory", __FILE__)

class SessionsControllerTest < ActionController::TestCase

	#
	# new
	#
	test "on GET to :new with no users in the DB should redirect to new_admin_user" do
		get :new
		assert_redirected_to new_admin_user_path
	end


  test "on GET to :new should render new" do
		Factory.user!
    get :new
    assert_response :success
		assert_template :new
  end


	#
	# create
	#
	test "on POST to :create (admin) should redirect to domains" do
    admin = Factory.admin_user!(:password => 'passwd', :password_confirmation => 'passwd')
    post :create, :session => {:username => admin.username, :password => 'passwd'}

    assert_redirected_to admin_domains_path
  end


  test "on POST to :create (owner) should redirect to domains" do
    owner = Factory.owner_user!(:password => 'passwd', :password_confirmation => 'passwd')
    post :create, :session => {:username => owner.username, :password => 'passwd'}

    assert_redirected_to owner_domains_path
  end


  test "on POST to :create with wrong password should redirect to sign_in" do
    user = Factory.user!(:password => 'passwd', :password_confirmation => 'passwd')
    post :create, :session => {:username => user.username, :password => 'wrongpasswd'}

		assert_template :new
		assert_response :success
		assert_equal "Invalid user/password combination", flash[:error]
  end


	#
	# destroy
	#
  test "on DELETE to destroy should redirect to root" do
    delete :destroy
		assert_redirected_to root_url
  end


end
