Rails.application.routes.draw do
  resource :playbills do
    collection do
      get :index
    end
    post :create
    patch :delete
  end
end
