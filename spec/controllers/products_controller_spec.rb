require 'spec_helper'

describe ProductsController do
	render_views
	
	
	describe "GET 'index'" do
		
		before(:each) do
			@product=Factory(:product)
			get 'index'
			@response=response
		end
			
		it "should respond successfully" do
				@response.should be_success
		end
		context "verify  html tags" do
			it "should have correct truncated description" do
				#had to extract tags from description  and fake truncation to get this test to work
				truncated_description_without_tags=@product.description.gsub(/<p>|<\/p>/,'')[0,77] + '...' 
				@response.should have_selector("table td.list_description dl dd", :content => truncated_description_without_tags )
			end
		
		end
	end
	
	
	describe "GET 'new'" do
		before(:each) do
			get 'new'
			@response=response
		end
			it "should respond successfully" do
				@response.should be_success
			end
			context "verify html tags" do
				it "should have correct heading" do
					@response.should have_selector("div#main h1", :content => "New product")
				end
				it "should have correct html fields for form" do
					@response.should have_selector("div#main div.field label", :for => "product_title", :content => "Title")
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


  