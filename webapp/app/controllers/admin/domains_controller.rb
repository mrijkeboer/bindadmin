class Admin::DomainsController < ApplicationController

	before_filter :check_admin

  # GET /admin/domains
  def index
    @domains = Domain.all
    # index.html.erb
  end


  # GET /admin/domains/1
  def show
    @domain = Domain.find(params[:id])
    # show.html.erb
  end


  # GET /admin/domains/new
  def new
    @domain = Domain.new
    # new.html.erb
  end


  # GET /admin/domains/1/edit
  def edit
    @domain = Domain.find(params[:id])
  end


  # POST /admin/domains
	def create
		@domain = Domain.new(params[:domain])

		if @domain.save
			flash[:notice] = 'Domain created.'
			redirect_to admin_domains_url
		else
			render :action => "new"
		end
	end


  # PUT /admin/domains/1
  def update
		@domain = Domain.find(params[:id])

		if @domain.update_attributes(params[:domain])
			flash[:notice] = 'Domain updated.'
			redirect_to admin_domains_url
		else
			render :action => "edit"
		end
	end


	# DELETE /admin/domains/1
	def destroy
		@domain = Domain.find(params[:id])
		if @domain.destroy
			flash[:notice] = 'Domain deleted.'
		end

		redirect_to admin_domains_url
	end


end
