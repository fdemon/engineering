class Order < ActiveRecord::Base
  belongs_to :worker
  belongs_to :supplier
  has_many :product_items, :dependent => :destroy
  validates_presence_of :pay_date, :supplier_id, :worker_id, :pay_type, :moneyofpayed, :moneyofdiscount
  before_destroy :ensure_not_referenced_by_any_product_item
  
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
