class ResetPasswordMailer < ApplicationMailer
  def reset_code(user)
    @reset_code = user.reset_password_code
    mail(to: user.email)
  end
end
