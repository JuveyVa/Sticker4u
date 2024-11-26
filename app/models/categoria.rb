class Categoria
  include Mongoid::Document
  include Mongoid::Timestamps

  # Campos
  field :categoria, type: String

  # Relación con Productos
  has_many :products, class_name: "Product"

  # Validaciones opcionales
  validates :categoria, presence: true, uniqueness: true
end
