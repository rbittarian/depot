require 'spec_helper'


describe OrdersController do
	render_views
	describe "GET 'new'" do
	
		context "for empty cart" do
			it "should redirect to store url" do
				get :new
				response.should redirect_to(store_path)
				response.flash[:notice].should =~ /Your cart is empty/
			end
		end
	
		 
	  # it "should create a new order" do
		# p=Factory(:product) 
		# @cart=Factory(:cart)
		# session[:cart_id] = @cart.id
		#l=Factory(:line_item ,:product => p, :cart => cart)
		# @line_items=Factory(:line_item, :product => p, :cart => @cart)
		
		# LineItem.where("product_id == ?", p.id).count.should == 1
		# @cart.line_items.product.count.should == 1
		#cart.line_items.product.count.should == 1
		 # get :new
		 # response.should be_success
	  # end
		
	end
	
	describe "POST 'create'" do	
		before(:each) do
			p=Factory(:product)
			cart=Factory(:cart)
			session[:cart_id] = cart.id
			cart.add_product(p.id, p.price)
			@order_attr = Factory.attributes_for(:order)
		end
		it "should create a new order" do
			lambda do
				post :create, :order => @order_attr
			end.should change(Cart, :count).by(-1)
		end
		it "should redirect to store and display correct message" do
			post :create, :order => @order_attr
			response.should redirect_to(store_url)
			flash[:notice].should =~ /Thank you for your order/i
		end
	end
	
	
end