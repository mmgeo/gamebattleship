# config/routes.rb
Rails.application.routes.draw do
  resources :games do
    collection do
      post 'upload'
    end
  end

  root 'games#index'
end
