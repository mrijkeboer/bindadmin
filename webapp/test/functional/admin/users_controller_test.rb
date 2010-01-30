require File.dirname(__FILE__) + "/../../test_helper"
require File.dirname(__FILE__) + "/../../factory"

class Admin::UsersControllerTest < ActionController::TestCase

	def setup
		@admin = Factory.admin_user!
		@user = Factory.user!
	end


	#
	# index
	#
	
	test "on GET to :index without admin_id in the session should redirect to sign_in" do
		get :index
		assert_redirected_to sign_in_path
	end


	test "on GET to :index should render users" do
		get :index, nil, {:admin_id => @admin.id}
		assert_response :success
		assert_template :index
		assert_not_nil assigns(:users)
	end


	#
	# show
	#
	
	test "on GET to :show without admin_id in the session should redirect to sign_in" do
		get :show, {:id => @user.id}
		assert_redirected_to sign_in_path
	end


	test "on GET to :show should render show" do
		get :show, {:id => @user.id}, {:admin_id => @admin.id}
		assert_response :success
		assert_template :show
		assert_not_nil assigns(:user)
	end


	#
	# new
	#
	
	test "on GET to :new without admin_id in the session should redirect to sign_in" do
		get :new
		assert_redirected_to sign_in_path
	end


	test "on GET to :new should render new" do
		get :new, nil, {:admin_id => @admin.id}
		assert_response :success
		assert_template :new
		assert_not_nil assigns(:user)
	end


	#
	# edit
	#

	test "on GET to :edit without admin_id in the session should redirect to sign_in" do
		get :edit, {:id => @user.id}
		assert_redirected_to sign_in_path
	end                                                                                


	test "on GET to :edit should render edit" do
		get :edit, {:id => @user.id}, {:admin_id => @admin.id}
		assert_response :success
		assert_template :edit
		assert_not_nil assigns(:user)
	end


	# 
	# create
	# 

	test "on POST to :create without admin_id in the session should redirect to sign_in" do
		post :create, {:user => Factory.user_attributes}
		assert_redirected_to sign_in_path
	end


	test "on POST to :create should create user" do
		@user.delete

		assert_difference("User.count", 1) do
			post :create, {:user => Factory.user_attributes}, {:admin_id => @admin.id}
		end

		assert_equal "User created.", flash[:notice]
	end


	#
	# update
	# 

	test "on PUT to :update without admin_id in the session should redirect to sign_in" do
		put :update, {:id => @user.id}, nil, :user => { }
		assert_redirected_to sign_in_path
	end


	test "on PUT to :update should update user" do
		put :update, {:id => @user.id}, {:admin_id => @admin.id}, :user => { }
		assert_redirected_to admin_users_path
		assert_equal "User updated.", flash[:notice]
	end


	#
	# destroy
	#

	test "on DELETE to :destroy without admin_id in the session should redirect to sign_in" do
		delete :destroy, {:id => @user.id}
		assert_redirected_to sign_in_path
	end


	test "on DELETE to :destroy should delete user" do
		assert_difference("User.count", -1) do
			delete :destroy, {:id => @user.id}, {:admin_id => @admin.id}
		end

		assert_redirected_to admin_users_path
		assert_equal "User deleted.", flash[:notice]
	end


end
