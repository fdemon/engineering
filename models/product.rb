class Product < ActiveRecord::Base
  belongs_to :unit
  has_many :product_items, :dependent => :destroy
  validates :name, :product_type, :unit_id, :presence => true
  validates :name, :uniqueness => true
  
  private
  
    def ensure_not_referenced_by_any_product_item
      if product_items.empty?
        return true
      else
        errors.add(:base, 'Product_items not empty')
        return false
      end
    end
end
