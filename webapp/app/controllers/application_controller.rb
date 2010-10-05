class ApplicationController < ActionController::Base

	include SessionsHelper

  protect_from_forgery


	private


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
			@domain = current_user.domains.find(domain_id)
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
