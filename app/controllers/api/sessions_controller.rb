class Api::SessionsController < Api::BaseController
  # skip_before_action :verify_authenticity_token
  skip_before_action :require_login!, only: [:create]

  def create
    puts "===== looking for user with params: #{params}"
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      puts "====== user authenticated :) ======"
      auth_token = user.generate_auth_token
      render json: { auth_token: auth_token }
    else
      puts "====== user not authenticated :( ======"
      if user.nil?
        puts "======== username wrong. no matches for #{params}"
      else
        puts "=== password wrong"
      end
      render json: { errors: [{ detail: 'Error with your login or password' }] }, status: 401
    end
  end

  def destroy
    user = current_user
    user.invalidate_token
    head :ok
  end
end
