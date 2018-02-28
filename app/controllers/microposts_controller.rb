class MicropostsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]
	before_action :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.new(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      flash[:success] = "Create Fail  !!!"
      redirect_to root_path
    end
  end

  def destroy
  	@micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end


	private

	def micropost_params
      params.require(:micropost).permit(:picurl)
    end

    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_path
      end
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
