Rails.application.routes.draw do
  # Ruta raíz que apunta a home#index
  root 'home#index'

  # Otras rutas
  resources :tickets
  resources :orders do
      member do
    get 'summary'
      end
    collection do
      get :confirmation
      post :update_quantity
    end
    collection do
      post :create_order_and_summary
    end
    member do
      post 'finalize_sale'
    end
  end
  
    resources :products
  resources :pruebas

  get 'startup/index'
  get 'dashboard/index', to: 'dashboard#index', as: 'dashboard'
  get 'ventas/index', to: 'ventas#index', as: 'ventas'
  get 'productos/index', to: 'productos#index', as: 'productos'
  get 'predictions', to: 'predictions#index', as: 'predictions'
  scope '/predictions' do
    get 'tickets/:id/products', to: 'tickets#show_products', as: 'ticket_show_products'
  end

  scope :dashboard do
    get 'index', to: 'dashboard#index'
    post 'filter_data', to: 'dashboard#filter_data'
  end

  get 'up', to: 'rails/health#show', as: :rails_health_check
end
