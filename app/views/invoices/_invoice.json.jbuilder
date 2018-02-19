json.extract! invoice, :id, :amount, :title, :description, :customer_id, :created_at, :updated_at
json.url invoice_url(invoice, format: :json)
