class Invoice < ApplicationRecord
  extend CustomIndexBootstrapper::ModelClassMethods

  belongs_to :customer
  has_custom_index :default_headers => [:title, :description, :amount, :customer_name]

  def index_display_customer_name
    "#{customer.first_name} #{customer.last_name}"
  end
end
