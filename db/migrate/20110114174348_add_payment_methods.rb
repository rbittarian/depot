class AddPaymentMethods < ActiveRecord::Migration

  def self.up
	PayType.create(:name => "Check", :short => "check")
    	PayType.create(:name => "Credit Card", :short => "cc")
    	PayType.create(:name => "Purchase Order", :short => "po")
  end

  def self.down
	PayType.delete_all
  end


end
