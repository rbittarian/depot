##load dummy orders

Order.transaction do
	1.upto(100) do |i|
		Order.create(:name => "Customer #{i}", :address => "#{i} Jump Street",
		:email => "customer-#{i}@example.com", :pay_type => "Check")
	end
end