class ModelMailer < ApplicationMailer
  default from: "me@sandbox7d2c3aaead6e4c5980147ace54c54730.mailgun.org.com"

  #def new_record_notification(order)
  #  @order= order
  #  mail to: "gerencia@losamigosdistribuidora.cl", subject: "Se creó una orden"
  #end
  #def new_user_notification(user)
  #  @user = user
  #  mail to: @user.email, subject: "Bienvenido/a a Los Amigos"
  #end

  def deleted_order_notification(order, user)
    @order = order
    @user = user
    @delete_message = "La orden #{@order.id} fue eliminada por el usuario #{@user}, del cliente #{@order.client_id}"
    mail to: "gerencia@losamigosdistribuidora.cl", subject: "Notificación: se eliminó una orden"
  end
end
