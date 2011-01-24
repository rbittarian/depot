require 'spec_helper'
   
describe "UserStories" do
	describe "buying a product" do
	
		# A user goes to the index page. They select a product, adding it to their
		# cart, and check out, filling in their details on the checkout form. When
		# they submit, an order is created containing their information, along with a
		# single line item corresponding to the product they added to their cart.
		it "should let the user buy a product" do
			##clear out all lineitems and orders
			LineItem.delete_all
			Order.delete_all
			###create a single product
			product=Factory(:product)
			###check if stores can be reached 
			get '/'
			response.should be_success
			response.should render_template("index")
			
			###send an Ajax request to create a new line_item
			xml_http_request :post, '/line_items', :product_id => product.id
			response.should be_success
			
			###check if the product is added to the current cart
			cart=Cart.find(session[:cart_id])
			cart.line_items.size.should == 1
			cart.line_items[0].product.should == product
			
			### check if it allows to popluate new order form
			get '/orders/new'
			response.should be_success
			response.should render_template("new")
			
			## check if it allows creation of a new order
			order_attr=Factory.attributes_for(:order)
			post_via_redirect "/orders",
					:order => order_attr
			response.should be_success
			response.should render_template("index")
			
			###once order is created , the cart should be empty
			cart=Cart.find(session[:cart_id])
			cart.line_items.should be_empty
			
			###the newly created order should exist in the db
			Order.count.should == 1
			order=Order.first
			order.name.should == order_attr[:name]
			order.address.should == order_attr[:address]
			order.email.should == order_attr[:email]
			order.pay_type.should == order_attr[:pay_type]
			order.line_items[0].product.should == product
			
			## verify if the order_recieved email has correct attributes
			mail=ActionMailer::Base.deliveries.last
			mail.to.should == [order.email]
			mail.from.should == ["depot@example.com"]
			mail.subject.should == "Pragprog Order Confirmation"
			
			###updating the order ship_date should send out an email (this is done by an admin)
			user=Factory(:user)
			integration_sign_in_as(user)
			put_via_redirect "/orders/#{order.id}", :order => order_attr.merge(:ship_date => "jan 4 2007") 
			response.should be_success
			mail=ActionMailer::Base.deliveries.last
			mail.subject.should == "Pragprog Order shipped"
		end
	end
	
	describe "system failure emails" do
		it "should send notification when invalid cart chosen" do
			user=Factory(:user)
			integration_sign_in_as(user)
			#session[:user_id]=user.id
			get "/carts/invalid"
			mail=ActionMailer::Base.deliveries.last
			mail.to.should == ["admin@depot.com"]
			mail.body.encoded.should =~ /invalid cart/
		end
	end
	   
end  