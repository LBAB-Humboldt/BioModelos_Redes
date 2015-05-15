Biomodis::Application.routes.draw do

  get 'species_groups/index'

  get 'species_groups/update'

  get 'species_groups/create'

  # get 'groups/index'
  #
  # get 'groups/show'
  #
  # get 'groups/update'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # devise_for :users
  devise_for :users, controllers: { registrations: "devise2/registrations" }
  #devise_for :users
  get "models/visor"
  get "models/download_model"
  get "species/species_content"
  get "species/species_models"
  get "users/edit_profile"
  get "comments/child_comments"
  get "home/feedback"
  post "home/send_message"
  post "ratings/rate_model"
  post "species/comment_point"
  post "group_users/set_state"
  post "species_groups/set_state"
  post "species/create_comment_point"
  #post "species/workshop_test"
  #post "species/create_workshop_test"
  resources :ratings, only: :update
  resources :comments, :only => [:create, :destroy]
  resources :home, :only => [:show]
  resources :reviews, :only => [:show, :create]
  resources :users, :only => [:show, :edit, :update]
  resources :user_relationships, :only => [:create]
  resources :models, :only => [:index, :new, :create]
  resources :groups do #, :only => [:index, :show, :new, :create, :update]

  end
  resources :species_groups, :only => [:index, :create, :update]
  resources :group_users do

  end
  resources :species, :only => [:new, :create, :edit, :update] do
    get :autocomplete, :on => :collection
  end 
  resources :faq, :only => [:index]

  # connect '/models/search', :controller => 'models', :action => 'search'
  #get "models/index"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#show'

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
