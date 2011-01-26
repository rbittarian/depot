class SessionsController < ApplicationController
  skip_before_filter :authorize
  def new
  end

  def create
    if User.count.zero?
		user=User.create(:name => params[:name],:password => 'a'.upto('z').to_a.shuffle.join[1,10] )
		session[:user_id]=user.id
		redirect_to(admin_url, :notice => "A temp user \"#{params[:name]}\" has been created for initial setup purposes. Please create a real admin user before signing out and then discard this user immediately!!")
	elsif user=User.authenticate(params[:name],params[:password])
		session[:user_id]=user.id
		redirect_to admin_url
	else
		redirect_to login_url, :alert => "Invalid username/password"
	end
  end

  def destroy
	session[:user_id]= nil
	redirect_to store_url, :notice => "You have logged out"
  end

end
