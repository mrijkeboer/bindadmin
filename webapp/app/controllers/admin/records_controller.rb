class Admin::RecordsController < ApplicationController

	layout "admin/domains"

	before_filter :check_admin
	before_filter :find_domain


	# GET /admin/domains/1/records
	def index
		redirect_to admin_domain_url(@domain)
	end


	# GET /admin/domains/1/records/1
	def show
		redirect_to admin_domain_url(@domain)
	end


	# GET /admin/records/new
	def new
		@record = Record.new
		# new.html.erb
	end


	def new_soa
		@record = Record.new
		# new_soa.html.erb
	end


	# GET /admin/domains/1/records/1/edit
	def edit
		@record = @domain.records.find(params[:id])

		if @record.soa?
			render :action => :edit_soa
		else
			# edit.html.erb
		end
	rescue
		redirect_to admin_domain_url
	end


	def edit_soa
		# edit_soa.html.erb
	end


	# POST /admin/domains/1/records
	def create
		@record = Record.new(params[:record])
		@domain.records << @record

		if @domain.save
			flash[:notice] = 'Record added.'
			redirect_to admin_domain_url(@domain)
		elsif @record.soa?
			render :action => :new_soa
		else
			render :action => :new
		end
	end


	# PUT /admin/domains/1/records/1
	def update
		@record = @domain.records.find(params[:id])

		if @record.update_attributes(params[:record])
			flash[:notice] = 'Record updated.'
			redirect_to admin_domain_url(@domain)
		elsif @record.soa?
			render :action => :edit_soa
		else
			render :action => :edit
		end
	rescue
		redirect_to admin_domain_url(@domain)
	end


	# DELETE /admin/domains/1/records/1
	def destroy
		@record = @domain.records.find(params[:id])

		if @domain.records.delete(@record)
			if @domain.save
				flash[:notice] = 'Record deleted.'
			end
		end

	ensure
		redirect_to admin_domain_url(@domain)
	end

end
