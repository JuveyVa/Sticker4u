class Product
  include Mongoid::Document
  include Mongoid::Timestamps

  # Campos
  field :name, type: String
  field :description, type: String
  field :inventory, type: Integer
  field :price, type: Float

  # Relación con Categoría
  belongs_to :categoria, class_name: "Categoria", optional: true

  # Validaciones opcionales
  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :inventory, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
