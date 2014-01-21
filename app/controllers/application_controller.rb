class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private

    def current_cart 
      Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      cart = Cart.create
      session[:cart_id] = cart.id
      cart
    end
    
    def increment_index_access_count
      if session[:index_access_count].nil?
        session[:index_access_count] = 0;
      end
      session[:index_access_count] += 1
    end
end
