GirlsGuild::Application.routes.draw do

  resources :signups
  resources :app_signups do
    collection do
      post :accept
      post :decline
      post :confirm
      post :cancel
    end
  end
  resources :work_signups

  match '/preregs/create', to: 'preregs#create'

  devise_for :users, :admins
    #get 'users/avatar.:id' => 'devise/registrations#avatar'


  resources :galleries, only: [:new, :create, :destroy]

  resources :albums, path: 'portfolio' do
    collection do
      post :add_photos
      post :remove_photos
      post :set_featured
    end
  end

  resources :photos do
    collection do
      post :sort
    end
  end

  resources :apprenticeships do
    resources :app_signups
    collection do
      post :cancel
      get :info
    end
  end
  match 'apprenticeships/:id/private' => 'apprenticeships#private', as: :private_apprenticeship
  match 'apprenticeships/:id/payment' => 'apprenticeships#payment', as: :payment_apprenticeship
  match 'apprenticeships/:id/confirmation' => 'apprenticeships#payment_confirmation', as: :payment_confirmation_apprenticeship

  resources :workshops do
    resources :work_signups
    collection do
      get :workshop_album
      post :cancel
    end
  end

  resources :event_skills, only: [:index]
  resources :event_tools, only: [:index]
  resources :event_requirements, only: [:index]

  resources :inquiries, only: [:create] do
    get 'static_pages/thanks', :on => :collection
  end

  root to: 'static_pages#home'

  match '/stripe/webhook', to: 'stripe#webhook'

  match '/faq', to: 'static_pages#faq'
  match '/about', to: 'static_pages#about'
  match '/whyjoin', to: 'static_pages#whyjoin'
  match '/contact', to: 'static_pages#contact'
  match '/thankyou', to: 'static_pages#thankyou'
  match '/newsletter', to: 'static_pages#newsletter'
  match '/testimonials', to: 'static_pages#testimonials'
  match '/privacypolicy', to:'static_pages#privacypolicy'
  match '/termsandconditions', to:'static_pages#termsandconditions'


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
