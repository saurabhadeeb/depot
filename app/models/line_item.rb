class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart
  attr_accessible :cart_id, :product_id, :product, :quantity
  
  def total_price
    quantity * product.price
  end
end
