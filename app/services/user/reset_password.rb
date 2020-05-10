class User::ResetPassword < ApplicationService
  required do
    string :email
    string :new_password
    string :reset_password_code
  end

  def execute
    check_reset_password_code_valid
    reset_password
    create_new_auth_token
    OpenStruct.new token: @new_auth_token, user: _user
  rescue ServiceError => e
    service_log status: :failure, message: "#{self.class.name} has errors: #{@errors.try(:message)}"
    service_backtrace e
  end

  private

  def check_reset_password_code_valid
    unless _user.reset_password_time > 30.minutes.ago && _user.reset_password_code == reset_password_code
      add_error __method__.to_sym, :failed, "Reset password code invalid"
      raise ServiceError
    end
  end

  def reset_password
    unless _user.update(password: new_password, reset_password_code: nil)
      add_error __method__.to_sym, :failed, "Reset password failed: #{_user.errors.messages}"
      raise ServiceError
    end
  end

  def create_new_auth_token
    @new_auth_token = _user.create_new_auth_token
    unless @new_auth_token
      add_error __method__.to_sym, :failed, "Create new auth token failed: #{_user.errors.messages}"
      raise ServiceError
    end
  end

  def _user
    @_user ||= ::User.find_for_authentication(email: email)
    return @_user if @_user

    add_error __method__.to_sym, :failed, "User with email=#{email} wasn't found"
    raise ServiceError
  end
end
