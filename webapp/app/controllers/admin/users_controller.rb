class Admin::UsersController < ApplicationController

	before_filter :check_admin, :except => [:new, :create]
	before_filter :check_admin_and_user_count, :only => [:new, :create]


  # GET /admin/users
  def index
    @users = User.all
		# index.html.erb
  end


  # GET /admin/users/1
  def show
    @user = User.find(params[:id])
    # show.html.erb
  end


  # GET /admin/users/new
  def new
    @user = User.new
    # new.html.erb
  end


  # GET /admin/users/1/edit
  def edit
    @user = User.find(params[:id])
  end


  # POST /admin/users
	def create
		@user = User.new(params[:user])

		if @user.save
			flash[:notice] = 'User created.'
			redirect_to admin_users_url
		else
			render :action => "new"
		end
	end


  # PUT /admin/users/1
	def update
		@user = User.find(params[:id])

		if @user.update_attributes(params[:user])
			flash[:notice] = 'User updated.'
			redirect_to admin_users_url
		else
			render :action => "edit" 
		end
	end


  # DELETE /admin/users/1
  def destroy
    @user = User.find(params[:id])
    if @user.destroy
			flash[:notice] = 'User deleted.'
		end

    redirect_to admin_users_url
  end

end
