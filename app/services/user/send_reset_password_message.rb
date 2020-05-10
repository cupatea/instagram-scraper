class User::SendResetPasswordMessage < ApplicationService
  required do
    string :email
  end

  def execute
    update_user
    send_reset_password_message
  rescue ServiceError => e
    service_log status: :failure, message: "#{self.class.name} has errors: #{@errors.try(:message)}"
    service_backtrace e
  end

  private

  def update_user
    unless _user.update(reset_password_code: _code, reset_password_time: Time.zone.now)
      add_error __method__.to_sym, :failed, "Update userfailed with errors: #{_user.errors.messages}"
      raise ServiceError
    end
  end

  def send_reset_password_message
    ResetPasswordMailer.reset_code(_user).deliver_later
  rescue => e
    add_error __method__.to_sym, :failed, e.message
    raise ServiceError, e
  end

  def _user
    @_user ||= ::User.find_for_authentication(email: email)
    return @_user if @_user

    add_error __method__.to_sym, :failed, "User with username=#{username} wasn't found"
    raise ServiceError
  end

  def _code
    @_code ||= "#{('A'..'Z').to_a.sample}#{(1000..9999).to_a.sample}"
  end
end
