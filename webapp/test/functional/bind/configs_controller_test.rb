require File.dirname(__FILE__) + "/../../test_helper"
require File.dirname(__FILE__) + "/../../factory"

class Bind::ConfigsControllerTest < ActionController::TestCase

	def setup
		@server = Factory.server!(:password => 'passwd', :password_confirmation => 'passwd')
	end

	#
	# index
	#
	
	test "on GET to :index with servername and wrong password should fail" do
		get :index, {:servername => @server.servername, :password => 'wrongpasswd', :last_change_id => 0}
		assert_response :bad_request
	end


	test "on GET to :index should render index" do
		get :index, {:servername => @server.servername, :password => 'passwd', :last_change_id => 0}
		assert_response :success
		assert_template :index
		assert_not_nil assigns(:last_change)
		assert_not_nil assigns(:domains)
		assert_not_nil assigns(:changes)
	end


end
