class Admin::MailServersController < ApplicationController

	layout "admin/defaults"

	before_filter :check_admin
	before_filter :find_default


	# GET /admin/defaults/1/mail_servers
	def index
		redirect_to admin_default_url(@default)
	end


	# GET /admin/defaults/1/mail_servers/1
	def show
		redirect_to admin_default_url(@default)
	end


	# GET /admin/defaults/1/mail_servers/new
	def new
		@mail_server = MailServer.new
	end


	# GET /admin/defaults/1/mail_servers/1/edit
	def edit
		@mail_server = @default.mail_servers.find(params[:id])
	end


	# POST /admin/defaults/1/mail_servers
	def create
		@mail_server = MailServer.new(params[:mail_server])
		@default.mail_servers << @mail_server

		if @default.save
			flash[:notice] = 'Mail server added.'
			redirect_to admin_default_url(@default)
		else
			render :action => :new
		end
	end


	# PUT /admin/defaults/1/mail_servers/1
	def update
		@mail_server = @default.mail_servers.find(params[:id])

		if @mail_server.update_attributes(params[:mail_server])
			flash[:notice] = 'Mail server updated.'
			redirect_to admin_default_url(@default)
		else
			render :action => :edit
		end
	end


	# DELETE /admin/defaults/1/mail_servers/1
	def destroy
		@mail_server = @default.mail_servers.find(params[:id])

		if @default.mail_servers.delete(@mail_server)
			if @default.save
				flash[:notice] = 'Mail server deleted.'
			end
		end

	ensure
		redirect_to admin_default_url(@default)
	end

end
