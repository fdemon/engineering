class Worker < ActiveRecord::Base
  has_many :orders
  before_destroy :ensure_not_referenced_by_any_order
  validates_presence_of :name, :worker_type
  validates :name, :uniqueness => true
  
  private
  
    def ensure_not_referenced_by_any_order
      if orders.empty?
        return true
      else
        errors.add(:base, 'order not empty')
        return false
      end
    end
    
end
