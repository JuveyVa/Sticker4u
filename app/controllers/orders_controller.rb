class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy, :summary]

  # Acción para mostrar el resumen de la orden
  def summary
    if @order.nil?
      redirect_to orders_path, alert: 'Orden no encontrada.'
    else
      @total_amount = @order.total_amount
    end
  end
  

  # Acción para mostrar todas las órdenes
  def index
    @products = Product.all
    @orders = Order.all
  end

  # Acción para mostrar una orden en particular
  def show
  end

  # Acción para crear una nueva orden
  def new
    @order = Order.new
  end

  # Acción para editar una orden existente
  def edit
  end

  # Acción para actualizar una orden
  def update
    if @order.update(order_params)
      redirect_to @order, notice: 'Orden actualizada correctamente.'
    else
      render :edit
    end
  end

  # Acción para destruir una orden
  def destroy
    @order.destroy
    redirect_to orders_path, notice: 'Orden eliminada correctamente.'
  end

  # Acción para confirmar una orden
  def confirmation
    @order = Order.find(params[:id])
    # Lógica de confirmación aquí
  end

  # Acción para actualizar la cantidad de un producto en una orden
  def update_quantity
    @order = Order.find(params[:id])
    # Lógica para actualizar la cantidad de productos en la orden
  end

  private

  # Establecer la orden con el ID proporcionado en la URL
  def set_order
    @order = Order.find_by(id: params[:id])  # Usamos `find_by` para evitar errores si no se encuentra la orden
  end

  # Parámetros permitidos para la creación y actualización de una orden
  def order_params
    params.require(:order).permit(:customer_name, :total_price, :status)
  end
end
