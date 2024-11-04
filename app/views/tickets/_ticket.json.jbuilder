json.extract! ticket, :id, :date, :total, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)
