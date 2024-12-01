class Ticket
  include Mongoid::Document
  include Mongoid::Timestamps
  field :date, type: Date
  field :total, type: Float
  has_and_belongs_to_many :products

  def product_frequency
    products.group_by(&:id).transform_values(&:size)
  end
end
