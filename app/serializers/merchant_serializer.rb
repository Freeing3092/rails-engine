class MerchantSerializer
  include JSONAPI::Serializer

  set_type :merchant
  attributes :name
end