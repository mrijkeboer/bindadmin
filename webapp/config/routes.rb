ActionController::Routing::Routes.draw do |map|


	map.root :controller => 'welcome'
	map.sign_in 'welcome/sign_in', :controller => 'welcome', :action => 'sign_in'
	map.sign_out 'welcome/sign_out', :controller => 'welcome', :action => 'sign_out'

	map.namespace :admin do |admin|
		admin.root :controller => 'domains', :action => 'index'

		admin.resources :defaults do |default|
			default.resources :mail_servers
			default.resources :name_servers
		end

		admin.resources :domains do |domain|
			domain.resources :allow_queries
			domain.resources :records
		end

		admin.resources :servers
		admin.resources :users
	end


	map.namespace :owner do |owner|
		owner.root :controller => 'domains', :action => 'index'

		owner.resources :domains do |domain|
			domain.resources :records
		end
	end

	
	map.namespace :bind do |bind|
		bind.configs 'configs/:servername/:password/:last_change_id', :controller => 'configs', :action => 'index'
	end

end
