class Invoice < ApplicationRecord
  extend CustomTables::Models::ClassMethods

  belongs_to :customer
  has_custom_index

  def index_display_customer_name
    "#{customer.first_name} #{customer.last_name}"
  end
end
