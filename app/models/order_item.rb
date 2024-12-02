class OrderItem
  include Mongoid::Document

  # Relación con los otros modelos
  belongs_to :order
  belongs_to :product

  # Campos específicos
  field :quantity, type: Integer, default: 0
  field :total_price, type: BigDecimal, default: 0.0

  # Callback para actualizar el total cuando cambie la cantidad
  before_save :update_total_price

  private

  # Método para actualizar el precio total cuando se actualiza la cantidad
  def update_total_price
    self.total_price = product.price * quantity
  end
end
