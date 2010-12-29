class Product < ActiveRecord::Base
	default_scope order(:title)
	
	validates :title, :description, :image_url, :presence => true
	validates :title, :uniqueness => { :case_sensitive => false }, :length => {:minimum => 10,
																			   :message => "should atleast be 10 characters long"}
	validates :price, :numericality => { :greater_than_or_equal_to => 0.01}
	validates :image_url, :format => {
						:with => %r{\.(gif|jpg|png)$}i,
						:message => 'must be a URL for GIF, JPG or PNG image.'}
end
