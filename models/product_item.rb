class ProductItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :order
  validates_presence_of :product_id, :quantity, :price, :order_id

end
