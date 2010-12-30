
test_setup_gems=%w[ autotest autotest-rails-pure autotest-growl rspec-core win32console] 

test_setup_gems.each do |g|
	system("gem install #{g} --no-ri --no-rdoc")
end

system("echo y|gem uninstall ZenTest")


system("gem install spork --no-ri --no-rdoc")

system("spork --bootstrap")

