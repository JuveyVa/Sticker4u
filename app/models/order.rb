class Order
  include Mongoid::Document
  include Mongoid::Timestamps
  field :date, type: Date
  field :total, type: BigDecimal
end
