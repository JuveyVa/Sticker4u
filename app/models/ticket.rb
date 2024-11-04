class Ticket
  include Mongoid::Document
  include Mongoid::Timestamps
  field :date, type: Date
  field :total, type: Float
end
