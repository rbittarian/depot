require 'spec_helper'


describe UsersController do
	render_views
   
   before(:each) do
		#test_sign_in_as(Factory(:user, :name => "temp"))
   end
   
   describe "POST 'create'" do
		   before(:each) do
			@user_attr = Factory.attributes_for(:user) #{:name => "Geico Gecko", :password => "Geico", :password_confirmation => "Geico"}
		   end
		it "should create a new user" do
			lambda do
				post :create, :user => @user_attr
			end.should change(User,:count).by(1)
		end
		
		it "should redirect to users page" do
			post :create, :user => @user_attr
			response.should redirect_to(users_path)
		end
		
	end
	
	  describe "PUT 'update'" do
	    it "should update an existing user" do
			user=Factory(:user)
			put :update, :id => user, :user => {:password => "newone", :password_confirmation => "newone"}
			response.should redirect_to(users_path)
		end
	  end

end