class CreateInvoices < ActiveRecord::Migration[5.1]
  def change
    create_table :invoices do |t|
      t.decimal :amount
      t.string :title
      t.text :description
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
