Opensourceforwomen::Application.routes.draw do

  get '/auth/:provider/callback' => "sessions#create"
  get '/sign_out' => "sessions#destroy", :as => 'sign_out'

  root :to => 'subscriptions#index'

  get '/projects' => "projects#index"

  resources :subscriptions

end
