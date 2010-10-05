BindAdmin::Application.routes.draw do

	root :to => 'sessions#new'
	
	match '/sign_in',  :to => 'sessions#new'
	match '/sign_out', :to => 'sessions#destroy'

	resources :sessions, :only => [:new, :create, :destroy]


	namespace :admin do
		root :to => 'domains#index'

		resources :defaults do
			resources :mail_servers
			resources :name_servers
		end

		resources :domains do
			resources :allow_queries
			resources :records
		end

		resources :servers
		resources :users
	end


	namespace :owner do
		root :to => 'domains#index'

		resources :domains do
			resources :records
		end
	end


	namespace :bind do
		match 'configs/:servername/:password/:last_change_id', :to => 'configs#index', :as => 'configs'
	end


end
