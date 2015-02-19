
Rails.application.routes.draw do


  resources :users, only: [:index, :show, :create, :edit, :destroy, :update]
  get '/signup' => 'users#new'
  post '/signup' => 'sessions#create'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  # Redirect from twitter callback_uri to remove params from url
  get '/redirect' => 'static_pages#redirect'

  namespace :api, defaults: {format: "json"} do
    resources :twitter_accounts, only: [:index, :create]
    resources :tweets, only: [:index, :create]
    post "/authenticate" => 'authentication#sign_in'
  end


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
    root 'static_pages#home'

  # Callback route to return to after the social media sign in
  get '/auth/:provider/callback', to: 'static_pages#home'
  
  # Web GUI for sidekiq processes
  require 'sidekiq/web' 
    mount Sidekiq::Web => '/sidekiq'

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
