class StoreController < ApplicationController
	skip_before_filter :authorize
  def index
		if params[:set_locale]
			redirect_to store_path(:locale => params[:set_locale])
		else
			@products=Product.all
			@cart=current_cart
		end
	if session[:count].nil?
		session[:count]=1
	else
		session[:count]+=1
	end
	@view_counter=session[:count]
  end

end
