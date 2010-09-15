class WelcomeController < ApplicationController

	before_filter :check_user_count, :only => :sign_in
	before_filter :check_signed_in, :except => :sign_in


	def index
		redirect_to sign_in_url
	end

	
	def sign_in
		session[:admin_id] = nil
		session[:owner_id] = nil

		if request.post?
			@user = User.authenticate(params[:username], params[:password])
			if @user != nil
				if @user.admin?
					session[:admin_id] = @user.id
					uri = session[:orig_uri] || admin_domains_url
				else
					session[:owner_id] = @user.id
					uri = session[:orig_uri] || owner_domains_url
				end

				session[:orig_uri] = nil
				redirect_to uri
			else
				flash[:error] = "Invalid user/password combination"
			end
		else
			# sign_in.html.erb
		end
	end


	def sign_out
		session[:admin_id] = nil
		session[:owner_id] = nil
		session[:orig_url] = nil
		redirect_to sign_in_url
	end

	
	private 

	def check_user_count
		if User.count == 0
			redirect_to new_admin_user_url
		end
	end


	def check_signed_in
		if @admin = User.find_by_id(session[:admin_id]) == nil
			if @owner = User.find_by_id(session[:owner_id]) == nil
				session[:orig_url] = request.fullpath
				redirect_to sign_in_url
			end
		end
	end

end
