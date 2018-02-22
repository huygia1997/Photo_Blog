class StaticPagesController < ApplicationController
	before_action :logged_in_yet?, only: [:home]
  def home
  end

  def about
  end

  private

  def logged_in_yet?
  	if (logged_in?)
  		redirect_to @current_user
  	end
  end
end
