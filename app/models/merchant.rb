class Merchant < ApplicationRecord
  has_many :items

  def self.name_search(query)
    Merchant.where("lower(name) like ?", "%#{query.downcase}%")
    .order("lower(name)")
    # .limit(1)
    .first
  end
end
