Factory.define :product do |product|
	
	product.title					"Book of Awesomeness"
	product.price					"75"
	product.description				"<p>No words to explain this book. But the fox could have done a better job explaining it</p>"
	product.image_url				"images/kpg.jpg"
	
end

Factory.define :cart do |cart|
end

# Factory.sequence :email do |n|
	# "person-#{n}@example.com" 
# end

# Factory.define :micropost do |micropost|
	# micropost.content "Foo Bar"
	# micropost.association :user
# end