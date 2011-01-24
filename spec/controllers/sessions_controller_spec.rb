require 'spec_helper'


describe SessionsController do

	describe "GET 'new'" do
		it "should be successful" do
			get :new
			response.should be_success
		end
	end
	
	describe "POST 'create'" do
		context "existing use logging in" do
			it "should login the user" do
				user=Factory(:user)
				post :create, :name => user.name, :password => user.password 
				response.should redirect_to admin_url
				user.id.should == session[:user_id]
			end
			
			it "should not login user with incorrect password" do
				user=Factory(:user)
				post :create, :name => user.name, :password => "incorrect" 
				response.should redirect_to login_url
			end
			
			it "should logout successfully" do
				user=Factory(:user)
				post :create, :name => user.name, :password => user.password 
				delete :destroy
				response.should redirect_to store_url
			end
			
		end
	end

end