class Invoice < ApplicationRecord
  belongs_to :merchant
  belongs_to :customer

  has_many :invoice_items
  has_many :items, through: :invoice_items

  def self.destroy_empty_invoices
    Invoice.all.each do |invoice|
    invoice.destroy if invoice.invoice_items.empty?
    end
  end
end
