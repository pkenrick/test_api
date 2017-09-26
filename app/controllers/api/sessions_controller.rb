class Api::SessionsController < Api::BaseController
  skip_before_action :verify_authenticity_token
  skip_before_action :require_login!, only: [:create]

  def create
    user = User.find_by(email: params[:email])

    if user
      puts "====== user found! ======"
    else
      puts "====== user not found :( ======"
    end
  end
end
