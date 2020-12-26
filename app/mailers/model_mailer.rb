class ModelMailer < ApplicationMailer

  #def deleted_order_notification(order, user)
  #  @order = order
  #  @user = user
  #  @delete_message = "La orden #{@order.id} fue eliminada por el usuario #{@user}, del cliente #{@order.client_id}"
  #  mail to: "gerencia@losamigosdistribuidora.cl", subject: "Notificación: se eliminó una orden"
  #end


  # using SendGrid's Ruby Library
  # https://github.com/sendgrid/sendgrid-ruby
  require 'sendgrid-ruby'
  include SendGrid

  def deleted_order_notification(order, user)
    @order = order
    @user = user
    @delete_message = "La orden #{@order.id} fue eliminada por el usuario #{@user}, del cliente #{@order.client_id}"
    from = Email.new(email: "gerencia@losamigosdistribuidora.cl")
    to = Email.new(email: "gerencia@losamigosdistribuidora.cl")
    subject = "mail"
    content = Content.new(type: 'text/plain', value: @delete_message)
    mail = Mail.new(from, subject, to, content)
    
    sg = SendGrid::API.new(api_key: ENV['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'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts response.status_code
    puts response.body
    puts response.headers
  end
end
