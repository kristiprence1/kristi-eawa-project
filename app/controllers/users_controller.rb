class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    if params[:search].present?
      @users = User.where("name ILIKE ?", "%#{params[:search]}%").all
    else
      @users = User.all
    end

  end
end
