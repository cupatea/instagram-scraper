class Admins::DashboardController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin'

  def index
    @instagram_users = InstagramUser.all
  end
end
