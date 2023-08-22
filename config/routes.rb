Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :devices do 
    get 'latest-timestamp', to: "devices#latest_timestamp", on: :member
    get 'cumulative-count', to: "devices#cumulative_count", on: :member
  end
end
