class StoreController < ApplicationController
  def index
    @products = Product.all
    @cart = current_cart
    @index_count = increment_index_access_count
    Rails.logger.debug("Inside StoreController - index action")
  end
end
