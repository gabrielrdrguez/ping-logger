Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html\



  resources :ping_logs do
    collection do
      get :start_job
      get :clear
      get :data_chart, format: :json
    end
  end
end
