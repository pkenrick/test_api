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
       puts("====== Error: User not found.") if user.nil?
       puts("====== Error: Password not valid.") if user && !user.authenticate(params[:session][:password])
       render 'new'
     end
   end

   def destroy
     logout
     redirect_to login_path
   end
end
