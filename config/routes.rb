Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root 'home#index'


  get 'experiment' => 'home#experiment', as: :experiment

  get "control_login" => 'control#login', as: :control_login
  
  post "validatecontroller" => 'control#validatecontroller', as: :validatecontroller

  get "control" => "control#index"

  get "changetime" => 'control#changetime'

  get 'export_sample_csv' => 'control#export_sample_csv', as: :export_sample_csv

  get 'change_status' => 'control#change_status'

  get "participant" => 'participant#index'

  get "start_experiment" => 'control#start_experiment'

  get "stop_experiment" => 'control#stop_experiment'

  get "reset_experiment" => 'control#reset_experiment'

  post 'save_quiz_answers' => 'questions#save_quiz_answers', :as => :save_quiz_answers
   
  get 'quiz' => 'questions#index'
  
  get 'statements' => 'statements#index'
  
  get '/participant/sample_video' => 'participant#sample_video'
  
  post 'upload'=>'control#save_upload'
  
  get 'change_enable_status' => 'control#change_enable_status'
  
  get 'changelimit' => 'control#changelimit'
  
  get 'payments'=> 'payments#calculate'
  
  get 'results'=> 'payments#results'
  
  post '/participant/save' => 'participant#save'
  
  get 'get_participant_info'=> 'participant#get_information'
  
  post 'save_user_info'=>'participant#save_user_information'

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
