class DashboardController < ApplicationController
  protect_from_forgery with: :null_session 

  def index
    @products = Product.all
    @tickets = Ticket.all
    @categories = Categoria.all
  
    # Datos iniciales
    @categories_data = @categories.map { |category| [category.categoria, category.products.count] }
    @tickets_data = @tickets.map { |ticket| [ticket.date.strftime('%Y-%m-%d'), ticket.total] }
  end
  
  def filter_data
    selected_products = params[:selected_products] || []
    selected_tickets = params[:selected_tickets] || []
    selected_categories = params[:selected_categories] || []
  
    # se filtran datos de tickets
    tickets_data = Ticket.where(:_id.in => selected_tickets.map { |id| BSON::ObjectId(id) })
                         .map { |ticket| [ticket.date.strftime('%Y-%m-%d'), ticket.total] }

    # se filtran datos de categorías
    categories_data = Categoria.where(:_id.in => selected_categories.map { |id| BSON::ObjectId(id) })
                               .map { |category| [category.categoria, category.products.count] }

    # se filtran productos por categorías seleccionadas
    if selected_categories.present?
      @products = Product.where(categoria_id: selected_categories.map { |id| BSON::ObjectId(id) })
    else
      @products = Product.all
    end

    # agrupamos los productos por fecha de creacion
    products_line_data = @products.group_by { |product| product.created_at.strftime("%Y-%m-%d") }
                                  .map { |date, products| [date, products.count] }

    # definimos la variable tickets_scatter_data 
    tickets_scatter_data = tickets_data.map { |ticket| { date: ticket[0], total: ticket[1] } }

    render json: {
      categories_pie_data: categories_data,  # Pie chart data
      tickets_scatter_data: tickets_scatter_data,  # Scatter chart data
      products_line_data: products_line_data  # Line chart data
    }
  end
end
