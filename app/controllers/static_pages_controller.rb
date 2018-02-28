class StaticPagesController < ApplicationController
	before_action :logged_in_yet?, only: [:home]
  before_action :loggout_user, only: [:home]
  layout 'about_layout', only: [:home]

  def home
    @users = User.all
  end

  def about
  end

  private

  def logged_in_yet?
  	if (logged_in?)
  		redirect_to @current_user
  	end
  end

  def loggout_user
      unless !logged_in?
        flash[:danger] = "Please log out."
        redirect_to current_user
      end
    end
end
