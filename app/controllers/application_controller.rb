class ApplicationController < ActionController::API
  include ActionController::Cookies

  rescue_from ActiveRecord::RecordInvalid, with: :render_not_valid

  # rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  before_action :authorize


  # def current_user
  #   User.find_by(id:session[:current_user])
  # end

  # def authorized_user
  #   return render json: {error: "Not Authorized"}, status: :unauthorized unless current_user
  # end


  private

  def render_not_valid(invalid)
    render json: {errors: invalid.record.errors.full_messages}, status: 422
  end

  # def render_not_found(error)
  #   render json: {error: "#{error.message}"}, status: :not_found
  # end

  def authorize
    @current_user = User.find_by(id: session[:user_id])
    return render json: { error: "Not authorized" }, status: :unauthorized unless @current_user
  end

end
