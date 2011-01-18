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
			@p=Factory(:product)
			cart=Factory(:cart)
			session[:cart_id] = cart.id
			cart.add_product(@p.id, @p.price)
			@order = Factory(:order)
			Factory(:line_item, :order => @order, :product => @p, :cart => cart)
			@order_attr=@order.attributes
		end
		it "should create a new order" do
				@order.should be_valid
			lambda do
				post :create, :order => @order_attr
			end.should change(Cart, :count).by(-1)
		end
		it "should redirect to store and display correct message" do
			post :create, :order => @order_attr
			response.should redirect_to(store_url)
			flash[:notice].should =~ /Thank you for your order/i
		end
		it "should deliver an order creation email" do
			lambda do
				post :create, :order => @order_attr
			end.should change(ActionMailer::Base.deliveries, :size).by(1)
		end
		context "order_received" do
			it "should have appropriate attributes" do
				@order.email.should =~ /Yuri@gattaca.com/
				mail = Notifier.order_received(@order)
				mail.subject.should =~ /Pragprog Order Confirmation/
				mail.to.should == [@order.email]
				mail.from.should == ["depot@example.com"]
				mail.body.encoded.should =~ /#{@p.title}/	
			end
		end
		context "order_shipped" do
			it "should have appropriate attributes" do
				mail = Notifier.order_shipped(@order)
				mail.subject.should =~ /Pragprog Order shipped/
				mail.to.should == [@order.email]
				mail.from.should == ["depot@example.com"]
				mail.body.encoded.should =~ /#{@p.title}/	
			end
		end
	
	end
	

	
	
end