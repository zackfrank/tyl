class SessionsController < Devise::SessionsController
  # skip_before_action :verify_authenticity_token, only: [:create]
  before_action :configure_sign_in_params, only: [:create]
  respond_to :json, :html

  def create
    user = User.find_by_email(sign_in_params[:email])
    puts sign_in_params
    puts user.inspect
    if user && user.valid_password?(sign_in_params[:password])
      @current_user = user
    else
      render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
    end
  end

  # def after_sign_in_path_for(_resource)
  # end

  # def show
  #   render json: session_as_json
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end


  def session_as_json
    {
      logged_in: user_signed_in?
    }
  end

end
