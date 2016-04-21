class Product < ActiveRecord::Base
  validates_numericality_of :price, :weight, greater_than: 0
end
