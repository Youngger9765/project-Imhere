Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  get "unauthorized" => 'authorize#not_authorized'

  resources :users
  get "/confirm_ok" => "users#confirm"

  get "demo" => "demo#index"
  root :to => "demo#index"

  post 'attachment/upload' => 'attachments#upload'


  namespace :admin do

    post "/test" => "webhook_events#test"
    post "/dev_test" => "webhook_events#dev_test"
    post "/order_create" => "webhook_events#order_create"
    post "/product_create_update" => "webhook_events#product_create_update"
    post "/product_delete" => "webhook_events#product_delete"
    post "/order_delete" => "webhook_events#order_delete"
    get "/activities/all" => "activities#index_all"

    resources :users
    resources :orders
    resources :merchants
    resources :artists
    resources :notifications

    resources :lotteries do
      member do
        get :users_list
        get :winners_list
        get :shipment
      end
    end

    resources :events do
      resources :activities do
        resources :activity_milestones
        resources :merchants

        resources :artists do
          member do
            get :remove_from_activity
          end
        end

        resources :lotteries do
          resources :users
          resources :prizes
        end

        member do
          get :choose_artist
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
    post "/getUserInfo" => "users#getUserInfo"
    post "/editUserInfo" => "users#editUserInfo"
    post "/lockFbLogin" => "users#lockFbLogin"
    post "/eraseFbLogin" => "users#eraseFbLogin"
    post "/editUserPassword" => "users#editUserPassword"
    post "/resetPasswordByToken" =>"users#resetPasswordByToken"
    post "/getOrder" => "users#getOrder"
    post "/getUserGifts" => "users#getUserGifts"
    post "/getUserMissGifts" => "users#getUserMissGifts"
    get "/countUserGiftsBadge" => "users#countUserGiftsBadge"
    post "/clickUserGifts" => "users#clickUserGifts"
    get "/countUserMissGiftsBadge" => "users#countUserMissGiftsBadge"
    post "/clickUserMissGifts" => "users#clickUserMissGifts"
    post "/addFavoriteActivity" => "users#addFavoriteActivity"
    post "/removeFavoriteActivity" => "users#removeFavoriteActivity"
    post "/showFavoriteActivity" => "users#showFavoriteActivity"
    post "/confirm" => "users#confirm"
    post "/modifyClickTime" =>"users#modifyClickTime"


    #event_info/activity_info
    resources :events do
      resources :activities do
        resources :merchants
      end
    end

    #lottery
    post "/userJoinLottery" => "lotteries#userJoinLottery"

    #order
    get "/getShopifyInfo" =>"merchants#getShopifyInfo"
    get "/getVariantInfo" =>"merchants#getVariantInfo"
    post "userCancelOrder" => "orders#userCancelOrder"

    #notification
    get "/getTodayNotification" =>"notifications#getTodayNotification"
    get "/getAlreadyNotification" => "notifications#getAlreadyNotification"
    get "/countNotificationBadge" => "notifications#countNotificationBadge"
    post "/clickNotification" => "notifications#clickNotification"

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
