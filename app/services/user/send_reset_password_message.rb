class User::SendResetPasswordMessage < ApplicationService
  required do
    string :username
  end

  def execute
    send_reset_password_message
    update_user
  rescue ServiceError => e
    service_log status: :failure, message: "#{self.class.name} has errors: #{@errors.try(:message)}"
    service_backtrace e
  end

  private

  def send_reset_password_message
    outcome = Instagram::SendMessage.run(username: _user.username, message: _message)

    unless outcome.success?
      add_error __method__.to_sym, :failed, "Send message failed with errors: #{outcome.errors.message}"
      raise ServiceError
    end
  end

  def update_user
    unless _user.update(reset_password_code: _code, reset_password_time: Time.zone.now)
      add_error __method__.to_sym, :failed, "Update userfailed with errors: #{_user.errors.messages}"
      raise ServiceError
    end
  end

  def _user
    @_user ||= ::User.find_for_authentication(username: username)
    return @_user if @_user

    add_error __method__.to_sym, :failed, "User with username=#{username} wasn't found"
    raise ServiceError
  end

  def _code
    @_code ||= "#{('A'..'Z').to_a.sample}#{(1000..9999).to_a.sample}"
  end

  def _message
    "Your code: #{_code}"
  end
end
