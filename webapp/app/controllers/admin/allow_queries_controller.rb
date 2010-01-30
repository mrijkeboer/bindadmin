class Admin::AllowQueriesController < ApplicationController

	layout "admin/domains"

	before_filter :check_admin
	before_filter :find_domain

  # GET /admin/domains/1/allow_queries
  def index
		redirect_to admin_domain_url(@domain)
  end


  # GET /admin/domains/1/allow_queries/1
  def show
		redirect_to admin_domain_url(@domain)
  end


  # GET /admin/domains/1/allow_queries/new
  def new
    @allow_query = AllowQuery.new
    # new.html.erb
  end


  # GET /admin/domains/1/allow_queries/1/edit
  def edit
    @allow_query = @domain.allow_queries.find(params[:id])
  end


  # POST /admin/domains/1/allow_queries
	def create
		@allow_query = AllowQuery.new(params[:allow_query])
		@domain.allow_queries << @allow_query

		if @domain.save
			flash[:notice] = 'Allow query added.'
			redirect_to admin_domain_url(@domain)
		else
			render :action => :new
		end
	end


	# PUT /admin/domains/1/allow_queries/1
	def update
		@allow_query = @domain.allow_queries.find(params[:id])

		if @allow_query.update_attributes(params[:allow_query])
			flash[:notice] = 'Allow query updated.'
			redirect_to admin_domain_url(@domain)
		else
			render :action => :edit
		end
	end


  # DELETE /admin/allow_queries/1
  def destroy
    @allow_query = @domain.allow_queries.find(params[:id])

    if @domain.allow_queries.delete(@allow_query)
			if @domain.save
				flash[:notice] = 'Allow query deleted.'
			end
		end

	ensure
    redirect_to admin_domain_url(@domain)
  end

end
