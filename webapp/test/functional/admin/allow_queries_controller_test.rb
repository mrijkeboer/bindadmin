require File.expand_path("../../../test_helper", __FILE__)
require File.expand_path("../../../factory", __FILE__)

class Admin::AllowQueriesControllerTest < ActionController::TestCase

	def setup
		@admin = Factory.admin_user!
		@allow_query = Factory.allow_query!
		@domain = @allow_query.domain
	end


	#
	# index
	#
	
	test "on GET to :index without admin_id in the session should redirect to sign_in" do
		get :index, {:domain_id => @domain.id}
		assert_redirected_to sign_in_path
	end


	test "on GET to :index should redirect to domains" do
		get :index, {:domain_id => @domain.id}, {:user_id => @admin.id}
		assert_redirected_to admin_domain_path(@domain)
	end


	#
	# show
	#
	
	test "on GET to :show without admin_id in the session should redirect to sign_in" do
		get :show, {:domain_id => @domain.id, :id => @allow_query.id}
		assert_redirected_to sign_in_path
	end


	test "on GET to :show should redirect to domains" do
		get :show, {:domain_id => @domain.id, :id => @allow_query.id}, {:user_id => @admin.id}
		assert_redirected_to admin_domain_path(@domain)
	end


	#
	# new
	#
	
	test "on GET to :new without admin_id in the session should redirect to sign_in" do
		get :new, {:domain_id => @domain.id}
		assert_redirected_to sign_in_path
	end


	test "on GET to :new should render new" do
		get :new, {:domain_id => @domain.id}, {:user_id => @admin.id}
		assert_response :success
		assert_template :new
		assert_not_nil assigns(:allow_query)
	end


	#
	# edit
	#

	test "on GET to :edit without admin_id in the session should redirect to sign_in" do
		get :edit, {:domain_id => @domain.id, :id => @allow_query.id}
		assert_redirected_to sign_in_path
	end                                                                                


	test "on GET to :edit should render edit" do
		get :edit, {:domain_id => @domain.id, :id => @allow_query.id}, {:user_id => @admin.id}
		assert_response :success
		assert_template :edit
		assert_not_nil assigns(:allow_query)
	end


	# 
	# create
	# 

	test "on POST to :create without admin_id in the session should redirect to sign_in" do
		post :create, {:domain_id => @domain.id, :allow_query => Factory.allow_query_attributes}
		assert_redirected_to sign_in_path
	end


	test "on POST to :create should create allow_query" do
		assert_difference("Domain.find(\"#{@domain.id}\").allow_queries.count", 1) do
			post :create, {:domain_id => @domain.id, :allow_query => Factory.allow_query_attributes}, {:user_id => @admin.id}
		end

		assert_equal "Allow query added.", flash[:notice]
	end


	#
	# update
	# 

	test "on PUT to :update without admin_id in the session should redirect to sign_in" do
		put :update, {:domain_id => @domain.id, :id => @allow_query.id}, nil, :allow_query => { }
		assert_redirected_to sign_in_path
	end


	test "on PUT to :update should update allow_query" do
		put :update, {:domain_id => @domain.id, :id => @allow_query.id}, {:user_id => @admin.id}, :allow_query => { }
		assert_redirected_to admin_domain_path(@domain)
		assert_equal "Allow query updated.", flash[:notice]
	end


	#
	# destroy
	#

	test "on DELETE to :destroy without admin_id in the session should redirect to sign_in" do
		delete :destroy, {:domain_id => @domain.id, :id => @allow_query.id}
		assert_redirected_to sign_in_path
	end


	test "on DELETE to :destroy should delete allow_query" do
		assert_difference("Domain.find(\"#{@domain.id}\").allow_queries.count", -1) do
			delete :destroy, {:domain_id => @domain.id, :id => @allow_query.id}, {:user_id => @admin.id}
		end

		assert_redirected_to admin_domain_path(@domain)
		assert_equal "Allow query deleted.", flash[:notice]
	end


end
