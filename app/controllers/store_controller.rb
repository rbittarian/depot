class StoreController < ApplicationController
  def index
	@products=Product.all
	if session[:count].nil?
		session[:count]=1
	else
		session[:count]+=1
	end
	
	@view_counter=session[:count]
  end

end
