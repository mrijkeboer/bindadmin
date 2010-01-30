class Bind::ConfigsController < ApplicationController

  # GET /bind/configs/:servername/:password/:last_change_id
  def index
		if Server.authenticate(params[:servername], params[:password])
			@last_change = Time.now.utc.to_i
			@domains = Domain.all
			@changes = Domain.changed(params[:last_change_id])
		else
			head :bad_request
		end
	end

end
