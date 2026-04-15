class Admin::UsersController < ApplicationController
  before_action :require_admin!

  def index
    @users = User.includes(:company).all
  end

  private

  def require_admin!
    head :unauthorized unless cookies[:admin] == "true"
  end
end
