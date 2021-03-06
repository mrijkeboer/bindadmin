require File.expand_path("../../../test_helper", __FILE__)
require File.expand_path("../../../factory", __FILE__)

class Admin::RecordsControllerTest < ActionController::TestCase

	def setup
		@admin = Factory.admin_user!
		@record = Factory.record!
		@domain = @record.domain
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
		get :show, {:domain_id => @domain.id, :id => @record.id}
		assert_redirected_to sign_in_path
	end


	test "on GET to :show should redirect to domains" do
		get :show, {:domain_id => @domain.id, :id => @record.id}, {:user_id => @admin.id}
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
		assert_not_nil assigns(:record)
	end


	#
	# edit
	#

	test "on GET to :edit without admin_id in the session should redirect to sign_in" do
		get :edit, {:domain_id => @domain.id, :id => @record.id}
		assert_redirected_to sign_in_path
	end                                                                                


	test "on GET to :edit should render edit" do
		get :edit, {:domain_id => @domain.id, :id => @record.id}, {:user_id => @admin.id}
		assert_response :success
		assert_template :edit
		assert_not_nil assigns(:record)
	end


	# 
	# create
	# 

	test "on POST to :create without admin_id in the session should redirect to sign_in" do
		post :create, {:domain_id => @domain.id, :record => Factory.record_attributes}
		assert_redirected_to sign_in_path
	end


	test "on POST to :create should create record" do
		assert_difference("Domain.find(\"#{@domain.id}\").records.count", 1) do
			post :create, {:domain_id => @domain.id, :record => Factory.record_attributes}, {:user_id => @admin.id}
		end

		assert_equal "Record added.", flash[:notice]
	end


	#
	# update
	# 

	test "on PUT to :update without admin_id in the session should redirect to sign_in" do
		put :update, {:domain_id => @domain.id, :id => @record.id}, nil, :record => { }
		assert_redirected_to sign_in_path
	end


	test "on PUT to :update should update record" do
		put :update, {:domain_id => @domain.id, :id => @record.id}, {:user_id => @admin.id}, :record => { }
		assert_redirected_to admin_domain_path(@domain)
		assert_equal "Record updated.", flash[:notice]
	end


	#
	# destroy
	#

	test "on DELETE to :destroy without admin_id in the session should redirect to sign_in" do
		delete :destroy, {:domain_id => @domain.id, :id => @record.id}
		assert_redirected_to sign_in_path
	end


	test "on DELETE to :destroy should delete record" do
		assert_difference("Domain.find(\"#{@domain.id}\").records.count", -1) do
			delete :destroy, {:domain_id => @domain.id, :id => @record.id}, {:user_id => @admin.id}
		end

		assert_redirected_to admin_domain_path(@domain)
		assert_equal "Record deleted.", flash[:notice]
	end


end
