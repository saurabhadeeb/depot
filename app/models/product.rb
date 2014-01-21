class Product < ActiveRecord::Base
  default_scope :order => 'title'
  
  has_many :line_items
  
  before_destroy :ensure_not_referenced_by_any_line_items
  
  def ensure_not_referenced_by_any_line_items
    if line_items.count == 0
      return true
    else
      errors.add(:base, 'Line Items present')
      return false
    end
  end

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
  validates :title, :length => {:minimum => 10}
end
