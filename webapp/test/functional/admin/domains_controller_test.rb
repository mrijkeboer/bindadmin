require File.expand_path("../../../test_helper", __FILE__)
require File.expand_path("../../../factory", __FILE__)

class Admin::DomainsControllerTest < ActionController::TestCase

	def setup
		@admin = Factory.admin_user!
		@domain = Factory.domain!
		@user = @domain.user
	end


	#
	# index
	#
	
	test "on GET to :index without admin_id in the session should redirect to sign_in" do
		get :index
		assert_redirected_to sign_in_path
	end


	test "on GET to :index should render domains" do
		get :index, nil, {:user_id => @admin.id}
		assert_response :success
		assert_template :index
		assert_not_nil assigns(:domains)
	end


	#
	# show
	#
	
	test "on GET to :show without admin_id in the session should redirect to sign_in" do
		get :show, {:id => @domain.id}
		assert_redirected_to sign_in_path
	end


	test "on GET to :show should render show" do
		get :show, {:id => @domain.id}, {:user_id => @admin.id}
		assert_response :success
		assert_template :show
		assert_not_nil assigns(:domain)
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
		assert_not_nil assigns(:domain)
	end


	#
	# edit
	#

	test "on GET to :edit without admin_id in the session should redirect to sign_in" do
		get :edit, {:id => @domain.id}
		assert_redirected_to sign_in_path
	end                                                                                


	test "on GET to :edit should render edit" do
		get :edit, {:id => @domain.id}, {:user_id => @admin.id}
		assert_response :success
		assert_template :edit
		assert_not_nil assigns(:domain)
	end


	# 
	# create
	# 

	test "on POST to :create without admin_id in the session should redirect to sign_in" do
		post :create, {:domain => Factory.domain_attributes}
		assert_redirected_to sign_in_path
	end


	test "on POST to :create should create domain" do
		@domain.delete
		@user.delete

		assert_difference("Domain.count", 1) do
			post :create, {:domain => Factory.domain_attributes}, {:user_id => @admin.id}
		end

		assert_equal "Domain created.", flash[:notice]
	end


	#
	# update
	# 

	test "on PUT to :update without admin_id in the session should redirect to sign_in" do
		put :update, {:id => @domain.id}, nil, :domain => { }
		assert_redirected_to sign_in_path
	end


	test "on PUT to :update should update domain" do
		put :update, {:id => @domain.id}, {:user_id => @admin.id}, :domain => { }
		assert_redirected_to admin_domains_path
		assert_equal "Domain updated.", flash[:notice]
	end


	#
	# destroy
	#

	test "on DELETE to :destroy without admin_id in the session should redirect to sign_in" do
		delete :destroy, {:id => @domain.id}
		assert_redirected_to sign_in_path
	end


	test "on DELETE to :destroy should delete domain" do
		assert_difference("Domain.count", -1) do
			delete :destroy, {:id => @domain.id}, {:user_id => @admin.id}
		end

		assert_redirected_to admin_domains_path
		assert_equal "Domain deleted.", flash[:notice]
	end


end
