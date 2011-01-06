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

	context "adding multiple duplicate products to cart" do
		before(:each) do
			3.times do
				post :create, :product_id => @product.id
			end
			@cart=assigns(:cart)
		end
		it "should create only one lineitem" do
			@cart.line_items.select {|i| i.product_id == @product.id}.count.should == 1
		end
		it "should set quantity " do
			@cart.line_items.select {|i| i.product_id == @product.id}.first.quantity.should == 3
		end
	end
	
	context "adding multiple unique products to cart" do
		before(:each) do
			@unique_products=[]
			3.times do
				product = Factory(:product)
				@unique_products << product
				post :create, :product_id => product.id
			end
			@cart=assigns(:cart)
		end
		it "should create lineitem for each unique product" do
			@cart.line_items.count.should == 3
		end
		it "should set the correct price and quantity" do
			@unique_products.each do |p|
				@cart.line_items.select{|l| l.product_id == p.id }.first.price.should == p.price
				@cart.line_items.select{|l| l.product_id == p.id }.first.quantity.should == 1
			end
		end
	end
	
  end
end