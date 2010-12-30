require 'spec_helper'

describe StoreController do
render_views

before(:each) do
			@product=Factory(:product)
end

  describe "GET 'index'" do
  
		before(:each) do
			get :index
			@response=response
		end
		
		subject { @response}
		it{ should be_success }
		
	  it "should have correct html tags" do	
		@response.should have_selector("div#columns div#side a", :count => 4 )
		@response.should have_selector(:title, :content => "Pragprog online")
		@response.should have_selector("div.entry h3", :content => @product.title)
		@response.should have_selector("div.price_line span.price", :content => '$75.00')
	end
  end

end
