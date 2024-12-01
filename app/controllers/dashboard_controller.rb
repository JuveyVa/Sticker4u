class DashboardController < ApplicationController
  protect_from_forgery with: :null_session # Si hay problemas con CSRF

  def index
    @products = Product.all
    @tickets = Ticket.all
    @categories = Categoria.all

    # Inicializar datos vacíos para las gráficas
    @categories_data = []
    @tickets_data = []
    @line_chart_data = []
  end

  def filter_data
    selected_products = params[:selected_products] || []
    selected_tickets = params[:selected_tickets] || []
    selected_categories = params[:selected_categories] || []
    
    # Filtrar datos de tickets
    tickets_data = Ticket.where(id: selected_tickets).map { |ticket| [ticket.date.strftime('%Y-%m-%d'), ticket.total] }

    # Filtrar datos de categorías
    categories_data = Categoria.where(id: selected_categories).map { |category| [category.categoria, category.products.count] }

    render json: {
      categories_pie_data: categories_data,
      tickets_scatter_data: tickets_data,
      line_chart_data: tickets_data
    }
  end
end
