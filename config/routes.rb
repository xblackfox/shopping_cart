Rails.application.routes.draw do
  devise_for :admins
  devise_for :users, :controllers => { registrations: 'users/registrations', :omniauth_callbacks => "users/omniauth_callbacks" }

  root to: "homes#index"

	get "carted_products", to: "carted_products#index"
	
	resources :products, only: [:show, :index] do
   		resources :carted_products, except: [:index]
	end

	namespace :admin do
		resources :products, only: [:index, :new, :create, :edit, :update, :destroy]
		resources :orderitems, only: [:index, :edit, :update, :destroy]
	end

	# post '/checkout' => "carted"
	post '/checkouts', to: "carted_products#checkouts"

	resources :checkouts,  only: [:show]
	resources :receipts, only: [:show] 

	resources :orderitems, only: [:create]

	if Rails.env.development?
    	mount LetterOpenerWeb::Engine, at: "/letter_opener"
  	end


end
