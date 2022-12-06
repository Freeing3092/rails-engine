class MerchantSerializer
  include JSONAPI::Serializer

  set_type :merchant
  attributes :name

  def self.serialize_merchants(merchants)
    {
      data: 
      merchants.map do |merchant|
        {
          id: merchant.id,
          type: 'merchant',
          attributes: {
            name: merchant.name
          }
        }
      end
    }
  end
end