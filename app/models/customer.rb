class Customer < ActiveRecord::Base
  belongs_to :ship_address, class_name: "Address"
  belongs_to :bill_address, class_name: "Address"

  validates_presence_of :first_name, :last_name, :email

  accepts_nested_attributes_for :ship_address, :bill_address
end
