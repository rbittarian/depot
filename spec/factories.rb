Factory.define :product do |product|
	
	product.title					"Book of Awesomeness"
	product.price					"75"
	product.description				"No words to explain this book"
	product.image_url				"images/kpg.jpg"
	
end

# Factory.sequence :email do |n|
	# "person-#{n}@example.com"
# end

# Factory.define :micropost do |micropost|
	# micropost.content "Foo Bar"
	# micropost.association :user
# end