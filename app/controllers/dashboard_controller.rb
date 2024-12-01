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
  
    # Filtrar datos de productos más vendidos
    products_data = Product.where(:_id.in => selected_products.map { |id| BSON::ObjectId(id) }).map do |product|
      total_sales = product.sales_count # Ahora se obtiene a través de la relación 'tickets'
      [product.name, total_sales]
    end.sort_by { |product| -product[1] }.take(10) # Ordenar por las ventas y tomar los 10 más vendidos

    # Filtrar datos de categorías
    categories_data = Categoria.where(:_id.in => selected_categories.map { |id| BSON::ObjectId(id) }).map do |category|
      [category.categoria, category.products.count]
    end

    # Enviar datos al cliente
    render json: {
      categories_pie_data: categories_data,
      tickets_scatter_data: tickets_data,
      products_line_data: products_data
    }
  end
end
