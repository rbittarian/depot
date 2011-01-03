class Product < ActiveRecord::Base

	has_many :line_items
	before_destroy :ensure_not_referenced_by_any_line_item
	default_scope :order => 'title'
	
	validates :title, :description, :image_url, :presence => true
	validates :title, :uniqueness => { :case_sensitive => false }, :length => {:minimum => 10,
																			   :message => "should atleast be 10 characters long"}
	validates :price, :numericality => { :greater_than_or_equal_to => 0.01}
	validates :image_url, :format => {
						:with => %r{\.(gif|jpg|png)$}i,
						:message => 'must be a URL for GIF, JPG or PNG image.'}
						
	# ensure that the product is not referenced by any line item
	def ensure_not_referenced_by_any_line_item
		if line_items.count.zero?
			return true
		else
			#errors[:base] << "Line Items present"
			errors.add(:base, "Line Items present")
			return false
		end
	end
						
end
