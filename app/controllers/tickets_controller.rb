class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[ show edit update destroy ]

  # GET /tickets or /tickets.json
  def index
    @tickets = Ticket.includes(:products)
  end

  # GET /tickets/1 or /tickets/1.json
  def show
    @ticket = Ticket.includes(:products).find(params[:id])
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
    @products = Product.all
  end

  # GET /tickets/1/edit
  def edit
    @products = Product.all
  end

  # POST /tickets or /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to tickets_path, notice: "Ticket was successfully created." }
        format.json { render :index, status: :created, location: @ticket }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tickets/1 or /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to tickets_path, notice: "Ticket was successfully updated." }
        format.json { render :index, status: :ok, location: @ticket }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1 or /tickets/1.json
  def destroy
    @ticket.destroy!

    respond_to do |format|
      format.html { redirect_to tickets_path, status: :see_other, notice: "Ticket was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.includes(:products).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ticket_params
      params.require(:ticket).permit(:date, :total, product_ids: [])
    end
end
