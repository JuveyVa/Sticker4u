class Order
  include Mongoid::Document
  include Mongoid::Timestamps
  
  has_many :order_items
  field :date, type: Date
  field :total, type: Float
  
  # Calcular el total del pedido sumando los precios de los OrderItems
  def total_amount
    order_items.sum(&:total_price)
  end

  # Obtener los productos asociados a este pedido a través de los OrderItems
  def products
    order_items.map(&:product)
  end
end
