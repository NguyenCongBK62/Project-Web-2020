class UsersController < ApplicationController
  def index
    @users = User.search(params[:term])
    respond_to :js
  end

  def show
  end
end