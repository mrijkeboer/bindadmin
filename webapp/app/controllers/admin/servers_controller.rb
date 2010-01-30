class Admin::ServersController < ApplicationController

	before_filter :check_admin

  # GET /admin/servers
  def index
    @servers = Server.all
		# index.html.erb
  end


  # GET /admin/servers/1
  def show
    @server = Server.find(params[:id])
    # show.html.erb
  end


  # GET /admin/servers/new
  def new
    @server = Server.new
    # new.html.erb
  end


  # GET /admin/servers/1/edit
  def edit
    @server = Server.find(params[:id])
  end


  # POST /admin/servers
	def create
		@server = Server.new(params[:server])

		if @server.save
			flash[:notice] = 'Server created.'
			redirect_to admin_servers_url
		else
			render :action => "new"
		end
	end


  # PUT /admin/servers/1
	def update
		@server = Server.find(params[:id])

		if @server.update_attributes(params[:server])
			flash[:notice] = 'Server updated.'
			redirect_to admin_servers_url
		else
			render :action => "edit" 
		end
	end


  # DELETE /admin/servers/1
  def destroy
    @server = Server.find(params[:id])
    if @server.destroy
			flash[:notice] = 'Server deleted.'
		end

    redirect_to admin_servers_url
  end

end
