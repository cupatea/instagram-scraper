class ApplicationController < ActionController::Base

  def crud_action! object:, action:, params: nil, path:
    if params ? object.public_send(action, params) : object.public_send(action)
      yield(object, action, params, path) if block_given?
      redirect_to path.try(:dig, :success) || path,
                  notice: t("flash.#{object.class.name.parameterize}.#{action}.success")
    elsif action == :save
      flash[:error] = object.errors.full_messages
      render :new
    else
      redirect_to path.try(:dig, :failure) || path,
                  flash: { error: object.errors.full_messages }
    end
  end

  def toggle_access! object:, path:
    redirect_to path, notice:
      if object.access_locked?
        object.unlock_access!
        t("flash.#{object.class.name.parameterize}.toggle_access.unlocked")
      else
        object.lock_access!
        t("flash.#{object.class.name.parameterize}.toggle_access.locked")
      end
  end

  protected

  def _reset_password_token_params
    { password: Devise.friendly_token.first(8) }
  end

  def _sort_and_search_params
    { sort: params[:sort],
      direction: params[:direction],
      search_query: params[:search_query] }
  end
end
