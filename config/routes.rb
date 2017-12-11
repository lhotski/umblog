Rails.application.routes.draw do
  resources :posts, only: :create do
    post :rate, on: :member
    collection do
      get :top
      get :ips_by_logins
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
