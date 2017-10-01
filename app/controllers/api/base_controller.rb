class Api::BaseController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :require_login!
  helper_method :user_signed_in?, :current_user

  def user_signed_in?
    current_user.present?
  end

  def current_user
    puts "====== in the right place ======="
    @current_user ||= authenticate_token
  end

  def require_login!
    puts "===== #{request.headers.each{ |key, value| puts "#{key}: #{value}"}} ======"
    return true if authenticate_token
    render json: { errors: [{ detail: 'Access Denied' }] }, status: 401
  end

  private

  def authenticate_token
    authenticate_with_http_token do |token, options|
      User.find_by(auth_token: token)
    end
  end

end
