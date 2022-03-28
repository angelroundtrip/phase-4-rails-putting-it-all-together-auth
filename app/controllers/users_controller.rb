class UsersController < ApplicationController
  skip_before_action :authorize, only: [:create]

  # * POST /signup
  def create
    user = User.create!(user_params)
      session[:user_id] = user.id
      render json: user, status: 201
  end

  # * GET /me
  # * current_user method is in application_controller. Allows access to current_user throughout the app
  def show
    render json: @current_user
  end

  private

  def user_params
    params.permit(:username, :password, :password_confirmation, :image_url, :bio)
  end

end
