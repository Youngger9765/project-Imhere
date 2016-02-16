Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  get "unauthorized" => 'authorize#not_authorized'

  resources :users

  get "demo" => "demo#index"
  root :to => "demo#index"

  post 'attachment/upload' => 'attachments#upload'

  namespace :admin do

    post "/test" => "webhook_events#test"

    resources :users

    resources :lotteries do
      member do
        get :users_list
      end
    end

    resources :events do
      resources :activities do
        resources :activity_milestones
        resources :merchants

        resources :lotteries do
          resources :users
        end
      end
    end
  end



  scope :path => '/api/v1/', :defaults => { :format => :json }, :module => "api_v1", :as => 'v1' do

    #auth
    post "/login" => "auth#login"
    post "/logout" => "auth#logout"
    post "/register" => "auth#register"

    post  "/reSendConfirmation" => "auth#reSendConfirmation"
    post  "/sendResetPassword" => "auth#sendResetPassword"

    #user_info
    get "/getUserInfo" => "users#getUserInfo"
    post "/editUserInfo" => "users#editUserInfo"
    post "/eraseFbLogin" => "users#eraseFbLogin"
    post "/editUserPassword" => "users#editUserPassword"

    #event_info/activity_info
    resources :events do
      resources :activities do
        resources :merchants
      end
    end

    #lottery
    post "/userJoinLottery" => "lotteries#userJoinLottery"

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
