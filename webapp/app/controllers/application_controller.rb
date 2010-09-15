class ApplicationController < ActionController::Base
  protect_from_forgery

	private


	def check_admin
		unless @admin = User.find_by_id(session[:admin_id])
			session[:orig_url] = request.fullpath
			redirect_to sign_in_url
		end
	end


	def check_admin_and_user_count
		unless @admin = User.find_by_id(session[:admin_id])
			if User.count > 0
				session[:orig_url] = request.fullpath
				redirect_to sign_in_url
			end
		end
	end


	def check_owner
		unless @owner = User.find_by_id(session[:owner_id])
			session[:orig_url] = request.fullpath
			redirect_to sign_in_url
		end
	end
	
	
	def find_domain
		domain_id = params[:domain_id]

		if domain_id
			@domain = Domain.find(domain_id)
		else
			redirect_to admin_domains_url
		end
	rescue
		redirect_to admin_domains_url
	end


	def find_owner_domain
		domain_id = params[:domain_id]

		if domain_id
			@domain = @owner.domains.find(domain_id)
		else
			redirect_to owner_domains_url
		end
	rescue
			redirect_to owner_domains_url
	end


	def find_default
		@default = Default.instance
	end


end
