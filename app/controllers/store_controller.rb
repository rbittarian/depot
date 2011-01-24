class StoreController < ApplicationController
	skip_before_filter :authorize
  def index
	@products=Product.all
	@cart=current_cart
	if session[:count].nil?
		session[:count]=1
	else
		session[:count]+=1
	end
	
	@view_counter=session[:count]
  end

end
