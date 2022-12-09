class Item < ApplicationRecord
  after_destroy :destroy_empty_invoices

  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

  def self.name_search(query)
    Item.where("lower(name) like ?", "%#{query.downcase}%")
    .order("lower(name)")
  end

  def self.price_search(min_price, max_price)
    Item.where("unit_price > ?", min_price.nil? ? 0 : min_price)
    .where("unit_price < ?", max_price.nil? ? Float::MAX : max_price)
    # Item.where("unit_price > ?", min_price.nil? ? 0 : min_price * 100)
    # .where("unit_price < ?", max_price.nil? ? Float::MAX : max_price * 100)
    .order("lower(name)")
  end

  private
  def destroy_empty_invoices
    Invoice.destroy_empty_invoices
  end
end
