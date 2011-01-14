require 'spec_helper'


describe Cart do
    it "should add a product successfully" do
		cart=Cart.create!
		product=Factory(:product)
		cart.add_product(product.id, product.price)
		cart.line_items.product.count.should == 1
	end
	
	

end