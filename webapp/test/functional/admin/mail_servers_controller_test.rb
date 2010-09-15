require File.expand_path("../../../test_helper", __FILE__)
require File.expand_path("../../../factory", __FILE__)

class Admin::MailServersControllerTest < ActionController::TestCase

	def setup
		@admin = Factory.admin_user!
		@mail_server = Factory.mail_server!
		@default = @mail_server.default
	end


	#
	# index
	#
	
	test "on GET to :index without admin_id in the session should redirect to sign_in" do
		get :index, {:default_id => @default.id}
		assert_redirected_to sign_in_path
	end


	test "on GET to :index should redirect to defaults" do
		get :index, {:default_id => @default.id}, {:admin_id => @admin.id}
		assert_redirected_to admin_default_path(@default)
	end


	#
	# show
	#
	
	test "on GET to :show without admin_id in the session should redirect to sign_in" do
		get :show, {:default_id => @default.id, :id => @mail_server.id}
		assert_redirected_to sign_in_path
	end


	test "on GET to :show should redirect to defaults" do
		get :show, {:default_id => @default.id, :id => @mail_server.id}, {:admin_id => @admin.id}
		assert_redirected_to admin_default_path(@default)
	end


	#
	# new
	#
	
	test "on GET to :new without admin_id in the session should redirect to sign_in" do
		get :new, {:default_id => @default.id}
		assert_redirected_to sign_in_path
	end


	test "on GET to :new should render new" do
		get :new, {:default_id => @default.id}, {:admin_id => @admin.id}
		assert_response :success
		assert_template :new
		assert_not_nil assigns(:mail_server)
	end


	#
	# edit
	#

	test "on GET to :edit without admin_id in the session should redirect to sign_in" do
		get :edit, {:default_id => @default.id, :id => @mail_server.id}
		assert_redirected_to sign_in_path
	end                                                                                


	test "on GET to :edit should render edit" do
		get :edit, {:default_id => @default.id, :id => @mail_server.id}, {:admin_id => @admin.id}
		assert_response :success
		assert_template :edit
		assert_not_nil assigns(:mail_server)
	end


	# 
	# create
	# 

	test "on POST to :create without admin_id in the session should redirect to sign_in" do
		post :create, {:default_id => @default.id, :mail_server => Factory.mail_server_attributes}
		assert_redirected_to sign_in_path
	end


	test "on POST to :create should create mail_server" do
		assert_difference("Default.find(\"#{@default.id}\").mail_servers.count", 1) do
			post :create, {:default_id => @default.id, :mail_server => Factory.mail_server_attributes}, {:admin_id => @admin.id}
		end

		assert_equal "Mail server added.", flash[:notice]
	end


	#
	# update
	# 

	test "on PUT to :update without admin_id in the session should redirect to sign_in" do
		put :update, {:default_id => @default.id, :id => @mail_server.id}, nil, :mail_server => { }
		assert_redirected_to sign_in_path
	end


	test "on PUT to :update should update mail_server" do
		put :update, {:default_id => @default.id, :id => @mail_server.id}, {:admin_id => @admin.id}, :mail_server => { }
		assert_redirected_to admin_default_path(@default)
		assert_equal "Mail server updated.", flash[:notice]
	end


	#
	# destroy
	#

	test "on DELETE to :destroy without admin_id in the session should redirect to sign_in" do
		delete :destroy, {:default_id => @default.id, :id => @mail_server.id}
		assert_redirected_to sign_in_path
	end


	test "on DELETE to :destroy should delete mail_server" do
		assert_difference("Default.find(\"#{@default.id}\").mail_servers.count", -1) do
			delete :destroy, {:default_id => @default.id, :id => @mail_server.id}, {:admin_id => @admin.id}
		end

		assert_redirected_to admin_default_path(@default)
		assert_equal "Mail server deleted.", flash[:notice]
	end


end
