require File.expand_path("../../../test_helper", __FILE__)
require File.expand_path("../../../factory", __FILE__)

class Admin::DefaultsControllerTest < ActionController::TestCase

	def setup
		@admin = Factory.admin_user!
		@default = Factory.default!
	end


	#
	# index
	#
	
	test "on GET to :index without admin_id in the session should redirect to sign_in" do
		get :index
		assert_redirected_to sign_in_path
	end


	test "on GET to :index should redirect to domains" do
		get :index, nil, {:user_id => @admin.id}
		assert_redirected_to admin_default_path(@default)
	end


	#
	# show
	#
	
	test "on GET to :show without admin_id in the session should redirect to sign_in" do
		get :show, {:id => @default.id}
		assert_redirected_to sign_in_path
	end


	test "on GET to :show should render show" do
		get :show, {:id => @default.id}, {:user_id => @admin.id}
		assert_response :success
		assert_template :show
		assert_not_nil assigns(:default)
	end


	#
	# new
	#
	
	test "on GET to :new without admin_id in the session should redirect to sign_in" do
		get :new
		assert_redirected_to sign_in_path
	end


	test "on GET to :new should redirect to defaults" do
		get :new, nil, {:user_id => @admin.id}
		assert_redirected_to admin_default_path(@default)
	end


	#
	# edit
	#

	test "on GET to :edit without admin_id in the session should redirect to sign_in" do
		get :edit, {:id => @default.id}
		assert_redirected_to sign_in_path
	end                                                                                


	test "on GET to :edit should render edit" do
		get :edit, {:id => @default.id}, {:user_id => @admin.id}
		assert_response :success
		assert_template :edit
		assert_not_nil assigns(:default)
	end


	# 
	# create
	# 

	test "on POST to :create without admin_id in the session should redirect to sign_in" do
		post :create, {:default => Factory.default_attributes}
		assert_redirected_to sign_in_path
	end


	test "on POST to :create should redirect to defaults" do
		post :create, {:default => Factory.default_attributes}, {:user_id => @admin.id}
		assert_redirected_to admin_default_path(@default)
	end


	#
	# update
	# 

	test "on PUT to :update without admin_id in the session should redirect to sign_in" do
		put :update, {:id => @default.id}, nil, :default => { }
		assert_redirected_to sign_in_path
	end


	test "on PUT to :update should update default" do
		put :update, {:id => @default.id}, {:user_id => @admin.id}, :default => { }
		assert_equal "Default updated.", flash[:notice]
	end


	#
	# destroy
	#

	test "on DELETE to :destroy without admin_id in the session should redirect to sign_in" do
		delete :destroy, {:id => @default.id}
		assert_redirected_to sign_in_path
	end


	test "on DELETE to :destroy should redirect to defaults" do
		delete :destroy, {:id => @default.id}, {:user_id => @admin.id}
		assert_redirected_to admin_default_path(@default)
	end


end
