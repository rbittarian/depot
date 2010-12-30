require 'spec_helper'

describe ProductsController do
	render_views
	
	
	describe "GET 'index'" do
		
		before(:each) do
			@product=Factory(:product)
		end
		describe "success" do
			it "should be successful" do
				get 'index'
				response.should be_success
			end
			it "should have correct html tags" do
				get 'index'
				response.should have_selector("tr")
			end
		end
	end
	
	
	describe "GET 'new'" do
		describe "success" do
			it "should be successful" do
				get 'new'
				response.should be_success
			end
		end
	end
	
	describe "GET 'show'" do
		before(:each) do
			@product=Factory(:product)
		end
		describe "success" do
			it "should be successful" do
				get :show, :id => @product
				response.should be_success
			end
		end
		
	end
	
	
	describe "GET 'edit'" do
		before(:each) do
			@product=Factory(:product)
		end
		
		it "should be successful" do
			get :edit, :id => @product
			response.should be_success
		end
	end

	describe "POST 'create'" do
	
		describe "failure" do
			before(:each) do
				@attr={:title=>"", :description => "", :price => 0, :image_url => ""}
			end
			it "should not create a product" do
				lambda do
					post :create, :product => @attr
				end.should_not change(Product, :count)
			end
			
		end
		
		describe "success" do
			before(:each) do
				@attr={:title => "Book of Awesome",:description=>"some description", :price => "125.00", :image_url => "image/abc.jpg"}
			end
			it "should create a new product" do
				lambda do
					post :create, :product => @attr
				end.should change(Product,:count).by(1)
			end
			
			it "should display the correct success message" do
				post :create, :product => @attr
				flash[:notice].should =~ /Product was successfully created./i
			end
			
		end
	
	end
	
	describe "PUT 'update'" do
		before(:each) do
			@product=Factory(:product)
			@invalid_attr={:title=>"", :description => "", :price => 0, :image_url => ""}
		end
		describe "failure" do
			it "should not update the product" do
				put :update, :id => @product, :product => @invalid_attr
				response.should render_template('edit')
			end
		end
		
		describe "success" do
			it "should update the product" do
				put :update, :id => @product, :product => @product.attributes.merge({:title => "power of ruby"})
				response.should redirect_to(product_path(@product))
				
			end
		end
	end
	
	describe "DELETE 'destroy'" do
	end

end


  