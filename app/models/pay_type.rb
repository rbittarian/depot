class PayType < ActiveRecord::Base
	ALL = self.order(:name).map{ |s| [s.name,s.short] }
end
