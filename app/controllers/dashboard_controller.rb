class DashboardController < ApplicationController
  protect_from_forgery with: :null_session # Si hay problemas con CSRF

  def index
    @products = Product.all
    @tickets = Ticket.all
    @categories = Categoria.all
  
    # Datos iniciales para las gráficas
    @categories_data = @categories.map { |category| [category.categoria, category.products.count] }
    @tickets_data = @tickets.map { |ticket| [ticket.date.strftime('%Y-%m-%d'), ticket.total] }
  end
  
  def filter_data
    selected_products = params[:selected_products] || []
    selected_tickets = params[:selected_tickets] || []
    selected_categories = params[:selected_categories] || []
  
    # Filtrar datos de tickets
    tickets_data = Ticket.where(:_id.in => selected_tickets.map { |id| BSON::ObjectId(id) })
                         .map { |ticket| [ticket.date.strftime('%Y-%m-%d'), ticket.total] }
  
    # Filtrar datos de categorías
    categories_data = Categoria.where(:_id.in => selected_categories.map { |id| BSON::ObjectId(id) })
                               .map { |category| [category.categoria, category.products.count] }
  
    # Enviar datos al cliente
    render json: {
      categories_pie_data: categories_data,
      tickets_scatter_data: tickets_data,
      categories_bar_data: categories_data
    }
  end
  
end
