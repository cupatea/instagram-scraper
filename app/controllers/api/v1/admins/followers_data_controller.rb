class Api::V1::Admins::FollowersDataController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users  = InstagramUser.all
    @data   = FollowersDatum.all
  end

  def show
    @data = FollowersDatum.where(instagram_user_id: params[:id])
  end
end
