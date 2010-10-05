require File.expand_path("../../../test_helper", __FILE__)
require File.expand_path("../../../factory", __FILE__)

class Admin::ServersControllerTest < ActionController::TestCase

	def setup
		@admin = Factory.admin_user!
		@server = Factory.server!
	end


	#
	# index
	#
	
	test "on GET to :index without admin_id in the session should redirect to sign_in" do
		get :index
		assert_redirected_to sign_in_path
	end


	test "on GET to :index should render servers" do
		get :index, nil, {:user_id => @admin.id}
		assert_response :success
		assert_template :index
		assert_not_nil assigns(:servers)
	end


	#
	# show
	#
	
	test "on GET to :show without admin_id in the session should redirect to sign_in" do
		get :show, {:id => @server.id}
		assert_redirected_to sign_in_path
	end


	test "on GET to :show should render show" do
		get :show, {:id => @server.id}, {:user_id => @admin.id}
		assert_response :success
		assert_template :show
		assert_not_nil assigns(:server)
	end


	#
	# new
	#
	
	test "on GET to :new without admin_id in the session should redirect to sign_in" do
		get :new
		assert_redirected_to sign_in_path
	end


	test "on GET to :new should render new" do
		get :new, nil, {:user_id => @admin.id}
		assert_response :success
		assert_template :new
		assert_not_nil assigns(:server)
	end


	#
	# edit
	#

	test "on GET to :edit without admin_id in the session should redirect to sign_in" do
		get :edit, {:id => @server.id}
		assert_redirected_to sign_in_path
	end                                                                                


	test "on GET to :edit should render edit" do
		get :edit, {:id => @server.id}, {:user_id => @admin.id}
		assert_response :success
		assert_template :edit
		assert_not_nil assigns(:server)
	end


	# 
	# create
	# 

	test "on POST to :create without admin_id in the session should redirect to sign_in" do
		post :create, {:server => Factory.server_attributes}
		assert_redirected_to sign_in_path
	end


	test "on POST to :create should create server" do
		@server.delete

		assert_difference("Server.count", 1) do
			post :create, {:server => Factory.server_attributes}, {:user_id => @admin.id}
		end

		assert_equal "Server created.", flash[:notice]
	end


	#
	# update
	# 

	test "on PUT to :update without admin_id in the session should redirect to sign_in" do
		put :update, {:id => @server.id}, nil, :server => { }
		assert_redirected_to sign_in_path
	end


	test "on PUT to :update should update server" do
		put :update, {:id => @server.id}, {:user_id => @admin.id}, :server => { }
		assert_redirected_to admin_servers_path
		assert_equal "Server updated.", flash[:notice]
	end


	#
	# destroy
	#

	test "on DELETE to :destroy without admin_id in the session should redirect to sign_in" do
		delete :destroy, {:id => @server.id}
		assert_redirected_to sign_in_path
	end


	test "on DELETE to :destroy should delete server" do
		assert_difference("Server.count", -1) do
			delete :destroy, {:id => @server.id}, {:user_id => @admin.id}
		end

		assert_redirected_to admin_servers_path
		assert_equal "Server deleted.", flash[:notice]
	end


end
