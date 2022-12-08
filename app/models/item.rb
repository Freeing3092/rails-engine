class Item < ApplicationRecord
  after_destroy :destroy_empty_invoices

  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

  private
  def destroy_empty_invoices
    Invoice.destroy_empty_invoices
  end
end
