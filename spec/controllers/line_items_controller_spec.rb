require 'spec_helper'


describe LineItemsController do
	render_views
  context "POST 'create'" do
	before(:each) do
			@product=Factory(:product)
	end
	it "should create a line item" do
		lambda do
			post :create, :product_id => @product.id
		end.should change(LineItem, :count).by(1)
	end
	
	it "should redirect to cart of the current line item" do
			post :create, :product_id => @product.id
			line_item=assigns(:line_item)
			response.should redirect_to(cart_path(line_item.cart))
	end
	# it "should display correct message" do
			# post :create, :product_id => @product.id
			# flash[:notice].should =~ /Line item was successfully created/
	# end
  end
end