Rails.application.routes.draw do
  # Rutas de los recursos principales
  resources :tickets
  resources :orders do 
    collection do 
        get :summary
      end
    end
  
  resources :products
  resources :pruebas

  # Ruta de inicio para "startup"
  get 'startup/index'

  # Rutas para el controlador "dashboard"
  scope :dashboard do
    get 'index', to: 'dashboard#index'
    post 'filter_data', to: 'dashboard#filter_data'
  end

  # Ruta de estado de la aplicación
  get 'up', to: 'rails/health#show', as: :rails_health_check

  # Ruta raíz
  root "dashboard#index"
end
