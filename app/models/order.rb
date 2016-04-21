class Order < Cart
  accepts_nested_attributes_for :customer
end