%w[ rubygems spork ].each {|g| require g}

  #require 'webrat'
  #require 'webrat/adapters/rack'
Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However, 
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
	# This file is copied to ~/spec when you run 'ruby script/generate rspec'
		# from the project root directory.
 ENV["RAILS_ENV"] ||= 'test'
 # unless defined?(Rails)
    require File.dirname(__FILE__) + "/../config/environment"
  #end
	require 'rspec/rails'

	# Requires supporting files with custom matchers and macros, etc,
	# in ./support/ and its subdirectories.
	Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

	RSpec.configure do |config|
		# == Mock Framework
		#
		# If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
		#
		# config.mock_with :mocha
		# config.mock_with :flexmock
		# config.mock_with :rr
		config.mock_with :rspec

		config.fixture_path = "#{::Rails.root}/spec/fixtures"
  
		####to fix "stack too deep" errors
		config.include Webrat::Matchers, :type => :views
  
		# If you're not using ActiveRecord, or you'd prefer not to run each of your
		# examples within a transaction, comment the following line or assign false
		# instead of true.
		config.use_transactional_fixtures = true
		
		#### create seed data, ie payment types
		load "#{Rails.root}/db/seeds.rb"
  
		### Part of a Spork hack. See http://bit.ly/arY19y
		# Emulate initializer set_clear_dependencies_hook in mmm
		# railties/lib/rails/application/bootstrap.rb
		ActiveSupport::Dependencies.clear
		
		def test_sign_in_as(user)
			session[:user_id]=user.id if defined? session
		end
		
		def test_sign_out
			session.delete :user_id
		end
		
		def integration_sign_in_as(user)
			visit login_path
			fill_in "Name", :with => user.name
			fill_in "Password", :with => user.password
			click_button "Log In"
		end
	
	end
end

Spork.each_run do
end


