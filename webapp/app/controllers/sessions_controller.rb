class SessionsController < ApplicationController

	before_filter :check_user_count, :only => :new

  def new
  end


  def create
		username = params[:session][:username]
		password = params[:session][:password]

		if user = User.authenticate(username, password)
			sign_in(user)
			if user.admin?
				uri = session[:orig_uri] || admin_domains_url
			else
				uri = session[:orig_uri] || owner_domains_url
			end
			session[:orig_uri] = nil
			redirect_to uri
		else
			flash.now[:error] = "Invalid user/password combination"
			render :action => "new"
		end
  end


  def destroy
		sign_out
		redirect_to root_url
  end


end
