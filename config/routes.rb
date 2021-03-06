Rails.application.routes.draw do
  root 'static_pages#index'

  resource :session, only: [:new, :create, :destroy]
  resources :users
  resources :sports
  resources :teams
  resources :gamedays, except: [:create]
  resources :matchups
  resources :results
  resources :rankings
  resources :game, controller: :matchups
  resources :public, only: [:index, :show]

  post 'gamedays', as: :gameday_sets, to: 'gamedays#create_many'
  post 'games', as: :game_sets, to: 'matchups#create_many'

  post 'matchups/save', to: 'matchups#save', as: :matchups_save
  get 'matchups/:id/reverse', to: 'matchups#reverse', as: :matchup_reverse
  post 'results/create', to: 'results#collection_create', as: :results_create

  get 'logout' => 'sessions#destroy'
  get 'login' => 'sessions#new', via: :get
  match '/help', to: 'static_pages#help', via: :get

  resources :sessions do
    collection do
      get 'forgot_password', to: 'sessions#forgot_password'
      post 'forgot_password', to: 'sessions#password_reset'
    end
  end
  
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
