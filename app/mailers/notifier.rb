class Notifier < ActionMailer::Base
  default :from => "depot@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.order_received.subject
  #
  def order_received(order)
    @order =order

    mail :to => order.email, :subject => 'Pragprog Order Confirmation'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.order_shipped.subject
  #
  def order_shipped(order)
    @order =order

    mail :to => order.email, :subject => 'Pragprog Order shipped'
  end
  
  def notify_admin(message)
	@admin_email="admin@depot.com"
	@message = message
	@time=Time.now
	 mail :to => @admin_email, :subject => 'System failure error'
  end
  
  
end
