module SetCurrent
  extend ActiveSupport::Concern

  included do
    before_action :set_current
  end

  def set_current
    Current.user  = _current_user  if _user_session_id && _current_user
    Current.admin = _current_admin if _admin_session_id && _current_admin
  end

  private

  def _admin_session_id
    @_admin_session_id ||= session['warden.user.admin.key']&.first&.first
  end

  def _user_session_id
    @_user_session_id ||= session['warden.user.user.key']&.first&.first
  end

  def _current_user
    @_current_user ||= User.find_by(id: _user_session_id)
  end

  def _current_admin
    @_current_admin ||= Admin.find_by(id: _admin_session_id)
  end
end
