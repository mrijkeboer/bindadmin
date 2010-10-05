require File.expand_path("../../../test_helper", __FILE__)
require File.expand_path("../../../factory", __FILE__)

class Owner::DomainsControllerTest < ActionController::TestCase

	def setup
		@owner = Factory.owner_user!
		@domain = Factory.domain!(:user => @owner)
	end


	#
	# index
	#
	
	test "on GET to :index without owner_id in the session should redirect to sign_in" do
		get :index
		assert_redirected_to sign_in_path
	end


	test "on GET to :index should render domains" do
		get :index, nil, {:user_id => @owner.id}
		assert_response :success
		assert_template :index
		assert_not_nil assigns(:domains)
	end


	#
	# show
	#
	
	test "on GET to :show without owner_id in the session should redirect to sign_in" do
		get :show, {:id => @domain.id}
		assert_redirected_to sign_in_path
	end


	test "on GET to :show should render show" do
		get :show, {:id => @domain.id}, {:user_id => @owner.id}
		assert_response :success
		assert_template :show
		assert_not_nil assigns(:domain)
	end


	#
	# new
	#
	
	test "on GET to :new without owner_id in the session should redirect to sign_in" do
		get :new
		assert_redirected_to sign_in_path
	end


	test "on GET to :new should redirect to domains" do
		get :new, nil, {:user_id => @owner.id}
		assert_redirected_to owner_domains_path
	end


	#
	# edit
	#

	test "on GET to :edit without owner_id in the session should redirect to sign_in" do
		get :edit, {:id => @domain.id}
		assert_redirected_to sign_in_path
	end                                                                                


	test "on GET to :edit should redirect to domains" do
		get :edit, {:id => @domain.id}, {:user_id => @owner.id}
		assert_redirected_to owner_domains_path
	end


	# 
	# create
	# 

	test "on POST to :create without owner_id in the session should redirect to sign_in" do
		post :create, {:domain => Factory.domain_attributes}
		assert_redirected_to sign_in_path
	end


	test "on POST to :create should redirect to domains" do
		post :create, {:domain => Factory.domain_attributes}, {:user_id => @owner.id}
		assert_redirected_to owner_domains_path
	end


	#
	# update
	# 

	test "on PUT to :update without owner_id in the session should redirect to sign_in" do
		put :update, {:id => @domain.id}, nil, :domain => { }
		assert_redirected_to sign_in_path
	end


	test "on PUT to :update should redirect to domains" do
		put :update, {:id => @domain.id}, {:user_id => @owner.id}, :domain => { }
		assert_redirected_to owner_domains_path
	end


	#
	# destroy
	#

	test "on DELETE to :destroy without owner_id in the session should redirect to sign_in" do
		delete :destroy, {:id => @domain.id}
		assert_redirected_to sign_in_path
	end


	test "on DELETE to :destroy should redirect to domains" do
		delete :destroy, {:id => @domain.id}, {:user_id => @owner.id}
		assert_redirected_to owner_domains_path
	end


end
