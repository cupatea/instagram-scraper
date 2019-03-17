class Admins::DashboardController < ApplicationController
  layout 'admin'
  def index
    @instagram_users = InstagramUser.all
  end
end
