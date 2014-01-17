class Product < ActiveRecord::Base
  attr_accessible :description, :image_url, :price, :title
  
  #All the text fields for product must be provided
  validates :title, :description, :image_url, :presence => true
  validates :title, :uniqueness => true
  validates :image_url, :format => {
    :with => %r{\.(gif|jpg|jpeg|png)\z}i,
    :message => "must be a URL for a GIF, JPG or PNG image."
  }
  
  # price has to be at least Re 1.
  validates :price, :numericality => {:greater_than_or_equal_to => 1.00}
end
