json.array!(@customers) do |customer|
  json.extract! customer, :id, :first_name, :last_name, :email, :ship_address_id, :bill_address_id
  json.url customer_url(customer, format: :json)
end
