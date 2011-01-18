Factory.define :product do |product|
	
	product.sequence(:title)	{ |n| "Book of Awesomeness #{n}" }
	product.price					"75"
	product.description				"<p>No words to explain this book. But the fox could have done a better job explaining it</p>"
	product.image_url				"images/kpg.jpg"
	
end

Factory.define :cart do |cart|
end

Factory.define :line_item do |line_item|
		line_item.association :product
		line_item.association :cart	
		line_item.association :order
end

Factory.define :order do |order|
	order.name		"Yuri"
	order.email		"Yuri@gattaca.com"
	order.pay_type	"check"
	order.address   "7201 Baker Street"
end

###############references#####

# Factory.sequence :email do |n|
	# "person-#{n}@example.com" 
# end

# Factory.define :micropost do |micropost|
	# micropost.content "Foo Bar"
	# micropost.association :user
# end