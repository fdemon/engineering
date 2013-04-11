class Unit < ActiveRecord::Base
  has_many :products
  before_destroy :ensure_not_referenced_by_any_product
  validates_presence_of :name
  validates :name, :uniqueness => true
  
  private
  
    def ensure_not_referenced_by_any_product
      if products.empty?
        return true
      else
        errors.add(:base, 'Product not empty')
        return false
      end
    end
end
