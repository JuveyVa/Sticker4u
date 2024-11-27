Rails.application.routes.draw do
  # Ruta raíz que apunta a home#index
  root 'home#index'

  # Otras rutas
  resources :tickets
  resources :orders
  resources :products
  resources :pruebas

  get 'startup/index'
  get 'dashboard/index', to: 'dashboard#index', as: 'dashboard'
  get 'ventas/index', to: 'ventas#index', as: 'ventas'
  get 'productos/index', to: 'productos#index', as: 'productos'

  scope :dashboard do
    get 'index', to: 'dashboard#index'
    post 'filter_data', to: 'dashboard#filter_data'
  end

  get 'up', to: 'rails/health#show', as: :rails_health_check
end
