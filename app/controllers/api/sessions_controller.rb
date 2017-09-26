class Api::SessionsController < Api::BaseController
  skip_before_action :verify_authenticity_token
  skip_before_action :require_login!, only: [:create]

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      puts "====== user authenticated :) ======"
      # auth_token = user.generate_auth_token
      render json: { auth_token: 'This is the secret auth token; shhhhhh!' }
    else
      puts "====== user not authenticated :( ======"
      render json: { errors: [{ detail: 'Error with your login or password' }] }
    end
  end
end
