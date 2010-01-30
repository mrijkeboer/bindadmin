class Admin::DefaultsController < ApplicationController

	before_filter :check_admin
	before_filter :find_default

  # GET /admin/defaults
  def index
		redirect_to admin_default_url(@default)
  end


  # GET /admin/defaults/1
  def show
		# show
  end


  # GET /admin/defaults/new
  def new
		redirect_to admin_default_url(@default)
  end


  # GET /admin/defaults/1/edit
  def edit
		# edit
  end


  # POST /admin/defaults
	def create
		redirect_to admin_default_url(@default)
	end


  # PUT /admin/defaults/1
	def update
		if @default.update_attributes(params[:default])
			flash[:notice] = 'Default updated.'
			redirect_to admin_default_url(@default)
		else
			render :action => :edit
		end
	end


  # DELETE /admin/users/1/defaults/1
  def destroy
		redirect_to admin_default_url(@default)
  end


end
