class PredictionsController < ApplicationController
    def index
        @products = Product.all
        @tickets = Ticket.all
    end
end