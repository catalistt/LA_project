class UserNotifierMailer < ApplicationMailer
    default :from => 'gerencia@losamigosdistibuidora.cl'
  
    # send a signup email to the user, pass in the user object that   contains the user's email address
    def send_deleted_order(order)
      email_send = 'losamigosdistribucion@gmail.com'
      @order = order
      mail( :to => email_send,
      :subject => 'Se ha eliminado una orden!' )
    end
end
