# Preview all emails at http://localhost:3000/rails/mailers/model_mailer
class ModelMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/model_mailer/new_record_notification
  def new_record_notification
    ModelMailer.new_record_notification
  end

  # Preview this email at http://localhost:3000/rails/mailers/model_mailer/new_user_notification
  def new_user_notification
    ModelMailer.new_user_notification
  end

  # Preview this email at http://localhost:3000/rails/mailers/model_mailer/deleted_order_notification
  def deleted_order_notification
    ModelMailer.deleted_order_notification
  end

end
