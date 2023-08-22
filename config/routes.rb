Rails.application.routes.draw do

  resources :devices do 
    get 'latest-timestamp', to: "devices#latest_timestamp", on: :member
    get 'cumulative-count', to: "devices#cumulative_count", on: :member
  end
end
