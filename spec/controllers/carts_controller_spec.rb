require 'spec_helper'

describe CartsController do
  render_views
  
    before(:each) do
		@cart=Factory(:cart)
		####session variable should be set to mimic cart creation; ie to make the cart the current user's cart###
		session[:cart_id]=@cart.id
	end
	
	describe "GET 'show'" do
		it "should display the cart contents" do
			get :show, :id => @cart.id
			response.should be_success
		end
		context "for invalid cart id" do
			it "should redirect to store url" do
				get :show, :id => "invalid_id"
				response.should redirect_to(store_url)
			end
			it "should display an error message" do
				get :show, :id => "invalid_id"
				flash[:notice].should =~ /invalid cart/
			end
		end
	end
	
	describe "DELETE 'destroy'" do
		it "should destroy cart" do
			lambda do
				delete :destroy, :id => @cart.to_param
			end.should change(Cart, :count).by(-1)
		end
		it "should redirect to store url" do
				delete :destroy, :id => @cart.to_param
				response.should redirect_to(store_url)
		end
		
		# it "should display appropriate message" do
			# delete :destroy, :id => @cart.to_param
			# flash[:notice].should =~ /Your cart is currently empty/
		# end
	end
	
	 describe "Cart functionality" do
	
		it "should add a product to the cart" do
			p=Factory(:product)
			@cart.add_product(p.id,p.price)
		end
	
		it "should create only one line item entry for the same product added mutliple times" do
			p=Factory(:product)
			3.times do
				@cart.add_product(p.id,p.price)
			end
			@cart.line_items.count.should == 1
		end
		
		it "should create a line item for each different product added" do
			5.times do
				p=Factory(:product)
				@cart.add_product(p.id,p.price)
			end
			@cart.line_items.count.should == 5
	    end
		
		it "should set the product price on the line item" do
			p=Factory(:product)
			@cart.add_product(p.id,p.price)
			#@cart.line_items.where("product_id == ?",p.id).first.price.should == p.price
			@cart.line_items.select {|i| i.product_id == p.id }.first.price.should == p.price
		end
		
	  
	 end
	
end

