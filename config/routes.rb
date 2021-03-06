require 'sidekiq/web'

class AuthConstraint
  # requires admin for viewing some stuff
  # currently used by sidekiq
  def self.matches?(request)
    request.session[:init] = true # Starts up the session so we can access values from it later.
    request.session['admin']
  end
end


Rails.application.routes.draw do

  post '/auth/:provider/callback', :to => 'sessions#create'
  get '/signout', :to => 'sessions#destroy', :as => :logout
  #post '/auth/failure', :to => 'sessions#failure'
  resources :winrates
  resources :avgstats
  resources :accounts
  resources :players
  #resources :matches, param: :match_id
  resources :matches
  resources :stats
  get '/accounts/:id/matches', to: 'players#index', as: :matchlist

  mount Sidekiq::Web => '/sidekiq', :constraints => AuthConstraint

  root 'stats#index'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
