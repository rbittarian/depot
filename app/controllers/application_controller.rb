class ApplicationController < ActionController::Base
  before_filter :authorize
  protect_from_forgery
  layout 'application'
  
  private
  
  def current_cart
	Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
		cart=Cart.create
		session[:cart_id]=cart.id
		cart
  end
  
  protected
  
  def authorize
	unless User.find_by_id(session[:user_id])
		if User.count.zero?
			flash[:notice] = "Please create a new user"
			redirect_to :controller => 'users', :action => 'new'
		else
			redirect_to login_url, :notice => "Please log in"
		end
	end
  end
  

end
