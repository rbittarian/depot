require 'spec_helper'


describe LineItem do
    it "should create a new line item" do
		p=Factory(:product)
		c=Factory(:cart)
		LineItem.create!(:product => p ,:cart => c)
	end
	
	it "should increment quantity on the line item" do
		c=Factory(:cart)
		p=Factory(:product)
		l=LineItem.create!(:product => p ,:cart => c)
		5.times do
			c.add_product(p.id, p.price)
		end
		c.line_items.first.id.should == l.id
	end

end