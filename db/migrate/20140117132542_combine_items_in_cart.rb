class CombineItemsInCart < ActiveRecord::Migration
  def change
    # replace multiple instances of same item with a single item
    Cart.all.each do |cart|
      # Count the no. of each product in the cart
      sums = cart.line_items.group(:product_id).sum(:quantity)
      
      sums.each do |prod_id, qty|
        # Remove line item and create a new one if more than 1
        if qty > 1
          # Remove individual items
          cart.line_items.where(:product_id => prod_id).delete_all
          
          cart.line_items.create(:product_id=>prod_id, :quantity=>qty)
        end
      end
    end
  end
  
  def self.down
    LineItem.where("quantity>1").each do |line_item|
      line_item.quantity.times do
        LineItem.create :cart_id=>line_item.cart_id, 
                        :product_id=>line_item.product_id,
                        :quantity=>1
      end
      line_item.destroy
    end
  end
  
end
