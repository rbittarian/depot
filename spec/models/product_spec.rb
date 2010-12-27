require 'spec_helper'

describe Product do
  #pending "add some examples to (or delete) #{__FILE__}"
  
  before(:each) do
	@attr={:title => "Book of Awesome",:description=>"some description", :price => "125.00", :image_url => "image/abc.jpg"}
  end
  
  
  it "should create a new instance given valid attributes" do
		Product.create!(@attr)

  end
  
  it "should require a title" do
	no_title_product=Product.new(@attr.merge(:title => ""))
	no_title_product.should be_invalid
  end
  
  
  it "should not accept prices less than  0.01" do
		wrong_price_product=Product.new(@attr.merge(:price => -1000))
		wrong_price_product.should_not be_valid
  end
  
  it "should not create a product with duplicate title irrespective of the case" do
		Product.create!(@attr)
		duplicate_title_product=Product.new(@attr.merge(:title => @attr[:title].upcase))
		duplicate_title_product.should_not be_valid
  end
  
  it "should reject an image of incorrect format" do
	invalid_format_image_urls= %w[ images/abc.pdf images/lcd.txt images/led.jpeg]
	invalid_format_image_urls.each do |imageurl|
		invalid_product=Product.new(@attr.merge(:image_url => imageurl))
		invalid_product.should_not be_valid
	end
  end
	
	it "should allow all valid image formats" do
		valid_format_image_urls= %w[ an.jpg abc.gif images/plastic.PNG]
		valid_format_image_urls.each do |imageurl|
		  valid_product=Product.new(@attr.merge(:image_url => imageurl))
		  valid_product.should be_valid
		end
	end

  
end
