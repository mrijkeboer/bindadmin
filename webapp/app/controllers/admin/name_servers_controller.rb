class Admin::NameServersController < ApplicationController

	layout "admin/defaults"

	before_filter :check_admin
	before_filter :find_default


	# GET /admin/defaults/1/name_servers
	def index
		redirect_to admin_default_url(@default)
	end


	# GET /admin/defaults/1/name_servers/1
	def show
		redirect_to admin_default_url(@default)
	end


	# GET /admin/defaults/1/name_servers/new
	def new
		@name_server = NameServer.new
	end


	# GET /admin/defaults/1/name_servers/1/edit
	def edit
		@name_server = @default.name_servers.find(params[:id])
	end


	# POST /admin/defaults/1/name_servers
	def create
		@name_server = NameServer.new(params[:name_server])
		@default.name_servers << @name_server

		if @default.save
			flash[:notice] = 'Name server added.'
			redirect_to admin_default_url(@default)
		else
			render :action => :new
		end
	end


	# PUT /admin/defaults/1/name_servers/1
	def update
		@name_server = @default.name_servers.find(params[:id])

		if @name_server.update_attributes(params[:name_server])
			flash[:notice] = 'Name server updated.'
			redirect_to admin_default_url(@default)
		else
			render :action => :edit
		end
	end


	# DELETE /admin/defaults/1/name_servers/1
	def destroy
		@name_server = @default.name_servers.find(params[:id])

		if @default.name_servers.delete(@name_server)
			if @default.save
				flash[:notice] = 'Name server deleted.'
			end
		end

	ensure
		redirect_to admin_default_url(@default)
	end

end
