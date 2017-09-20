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

   def test_get
     sample_hash = { 1 => 'one', 2 => 'two', 3 => 'three' }
     puts "====== inside the test get method ======"
     render json: sample_hash.to_json, status: :ok
   end

   def test_post
     sample_hash = { 1 => 'one', 2 => 'two', 3 => 'three' }
     puts "====== inside the test post method ======"
     render json: sample_hash.to_json, status: :ok
   end
end
