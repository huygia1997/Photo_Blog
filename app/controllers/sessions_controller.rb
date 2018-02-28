class SessionsController < ApplicationController
	before_action :loggout_user, only: [:new, :create]
  def new

  end
  def create
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
  		log_in(user)
  		remember(user)
  		redirect_to user
  	else
 		flash.now[:danger] = 'Invalid email or password !!!' 		
 		render 'new'
  	end
  	
  end
  def destroy
  	log_out if logged_in?
  	redirect_to root_path
  	
  end

  private 
	  def loggout_user
	      unless !logged_in?
	        flash[:danger] = "Please log out."
	        redirect_to current_user
	      end
	    end


end
