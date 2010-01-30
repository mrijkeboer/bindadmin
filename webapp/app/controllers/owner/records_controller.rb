class Owner::RecordsController < ApplicationController

	layout "owner/domains"

	before_filter :check_owner
	before_filter :find_owner_domain

	# GET /owner/domains/1/records
	def index
		redirect_to owner_domain_url(@domain)
	end


	# GET /owner/domains/1/records/1
	def show
		redirect_to owner_domain_url(@domain)
	end


	# GET /owner/domains/1/records/new
	def new
		@record = Record.new
		# new.html.erb
	end


	# GET /owner/domains/1/records/1/edit
	def edit
		@record = @domain.records.find(params[:id])
	rescue
		redirect_to owner_domain_records_url
	end


	# POST /owner/domains/1/records
	def create
		@record = set_record_values(Record.new, params)
		@domain.records << @record

		if @domain.save
			flash[:notice] = 'Record added.'
			redirect_to owner_domain_url(@domain)
		else
			render :action => :new
		end
	end


	# PUT /owner/domains/1/records/1
	def update
		@record = @domain.records.find(params[:id])

		if edit_allowed?(@record)
			set_record_values(@record, params)

			if @record.save
				flash[:notice] = 'Record updated.'
				redirect_to owner_domain_url(@domain)
			else
				render :action => :edit
			end
		else
			flash[:error] = 'Locked record, not updated.'
			redirect_to owner_domain_url(@domain)
		end
	rescue
		redirect_to owner_domain_url(@domain)
	end


	# DELETE /owner/domains/1/records/1
	def destroy
		@record = @domain.records.find(params[:id])

		if delete_allowed?(@record)
			if @domain.records.delete(@record)
				if @domain.save
					flash[:notice] = 'Record deleted.'
				end
			end
		else
			flash[:error] = 'Locked record, not deleted.'
		end

	ensure
		redirect_to owner_domain_url(@domain)
	end


	private



	def delete_allowed?(record)
		if record.locked
			return false
		else
			return true
		end
	end


	def edit_allowed?(record)
		return delete_allowed?(record)
	end


	def set_record_values(record, values)
		if values[:record]
			record.name = values[:record][:name]
			record.ttl = values[:record][:ttl]
			record.type = values[:record][:type]
			record.pref = values[:record][:pref]
			record.content = values[:record][:content]
		end
		return record
	end

end
