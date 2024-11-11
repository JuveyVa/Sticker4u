class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]

  # GET /orders or /orders.json
  def index
    # Definir 8 productos con precios específicos e imagenes de prueba
    @products = [
      OpenStruct.new(id: 1, name: "Producto 1", price: 10.0, image_url: "https://via.placeholder.com/150"),
      OpenStruct.new(id: 2, name: "Producto 2", price: 20.0, image_url: "https://via.placeholder.com/150"),
      OpenStruct.new(id: 3, name: "Producto 3", price: 30.0, image_url: "https://via.placeholder.com/150"),
      OpenStruct.new(id: 4, name: "Producto 4", price: 40.0, image_url: "https://via.placeholder.com/150"),
      OpenStruct.new(id: 5, name: "Producto 5", price: 15.0, image_url: "https://via.placeholder.com/150"),
      OpenStruct.new(id: 6, name: "Producto 6", price: 25.0, image_url: "https://via.placeholder.com/150"),
      OpenStruct.new(id: 7, name: "Producto 7", price: 35.0, image_url: "https://via.placeholder.com/150"),
      OpenStruct.new(id: 8, nam: "Producto 8", price: 45.0, image_url: "https://via.placeholder.com/150")
    ]
  end


  # GET /orders/1 or /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: "Order was successfully created." }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy!

    respond_to do |format|
      format.html { redirect_to orders_path, status: :see_other, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:date, :total)
    end
end
