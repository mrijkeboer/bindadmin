class Owner::DomainsController < ApplicationController

	before_filter :check_owner

  # GET /owner/domains
  def index
    @domains = current_user.domains.all
    # index.html.erb
  end


  # GET /owner/domains/1
  def show
		@domain = current_user.domains.find(params[:id])
  end


  # GET /owner/domains/new
  def new
		redirect_to owner_domains_url
  end


  # GET /owner/domains/1/edit
  def edit
		redirect_to owner_domains_url
  end


  # POST /owner/domains
	def create
		redirect_to owner_domains_url
	end


  # PUT /owner/domains/1
  def update
		redirect_to owner_domains_url
	end


	# DELETE /owner/domains/1
	def destroy
		redirect_to owner_domains_url
	end

end
