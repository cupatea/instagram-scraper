class Admins::InstagramUsersController < ApplicationController
  before_action :authenticate_admin!
  helper_method :_sort_column, :_sort_direction
  before_action :_set_user, only: %i[show destroy]
  layout "admin"

  def index
    @users = InstagramUser.page(params[:page])
  end

  def show; end

  def destroy
    if current_admin.root?
      crud_action! object: @user,
                   action: :destroy,
                   path: admins_users_path(_sort_and_search_params)
    else
      redirect_to(admins_users_path(_sort_and_search_params), notice: t("access_denied"))
    end
  end

  private

  def _allowed_search_params
    User::USERS_ALLOWED_PARAMS.map { |key| [key, params[:search_query]] }.to_h
  end

  def _sort_column
    User::USERS_ALLOWED_PARAMS.include?(params[:sort]) ? params[:sort] : "id"
  end

  def _sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def _set_user
    @user = InstagramUser.find_by(id: params[:id])
    redirect_to(admins_instagram_users_path, error: t("user_not_found")) unless @user
  end
end