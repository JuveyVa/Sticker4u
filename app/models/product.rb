class Product
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic 

  # Campos
  field :name, type: String
  field :description, type: String
  field :inventory, type: Integer
  field :price, type: Float
  field :image, type: String 

  has_many :order_items
  # Relación con Categoría
  belongs_to :categoria, class_name: "Categoria", optional: true

  # Validaciones opcionales
  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :inventory, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # Total de tickets
  def self.total_tickets
    self.tickets.count
    end

  # Sop(x): frecuencia relativa del producto
  def self.sop(product_id)
    total_tickets = self.total_tickets
    return 0 if total_tickets.zero?

    count = Ticket.where(product_ids: product_id).count
    (count.to_f / total_tickets).round(2)
  end

   # Sop(x U n): frecuencia relativa conjunta de dos productos
  def self.sop_union(product_id, other_product_id)
    total_tickets = self.total_tickets
    return 0 if total_tickets.zero?

    count = Ticket.where(:product_ids.all => [product_id, other_product_id]).count
    (count.to_f / total_tickets).round(2)
  end
  def sales_count
    Ticket.where(product_ids: self.id).count
  end
end
