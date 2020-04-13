class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]

  def create
    user = User.new(
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation]
    )
    if user.save
      @current_user = user
    else
      render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
    end
  end
end