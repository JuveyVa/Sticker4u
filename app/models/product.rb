class Product
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :description, type: String
  field :image, type: String
  field :inventory, type: Integer
  field :price, type: Float
end
