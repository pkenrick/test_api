class SessionsController < ApplicationController
   def new
   end

   def create
     puts "========"
     puts params
     puts "========"
     user = User.find_by(email: params[:session][:email].downcase)
     if user && user.authenticate(params[:session][:password])
       login(user)
       redirect_to user
     else
       Rails.logger.error("Error: User not found.") if user.nil?
       Rails.logger.error("Error: Password not valid.") if user && !user.authenticate(params[:session][:password])
       render 'new'
     end
   end

   def destroy
     logout
     redirect_to login_path
   end
end
