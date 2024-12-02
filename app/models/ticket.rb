class Ticket
  include Mongoid::Document
  include Mongoid::Timestamps
  field :date, type: Date
  field :total, type: Float
  has_and_belongs_to_many :products, class_name: 'Product', inverse_of: :tickets
  
  # Devuelve el conteo total de tickets
  def self.total_tickets
    count
  end
end
