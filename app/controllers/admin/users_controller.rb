class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:edit, :do_edit, :destroy]
  before_action :check_admin

  def index
    @users = User.all
  end

  def edit
  end

  def do_edit
    @user.update!(user_params)

    if @user.save
      redirect_to action: "index"
    else
      flash.alert = "Errors: #{@user.errors.full_messages.to_sentence}"
      redirect_to "#{admin_edit_path}/#{@user.id}"
    end
  end

  def destroy
    @user.destroy

    redirect_to action: :index
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def check_admin
      unless session[:user_id]
        flash.alert = "You need to log in to see this page"
        redirect_to login_path
      else
        @logged_in_as = User.find(session[:user_id])

        unless @logged_in_as.admin?
          flash.alert = "Admin privs required"
          redirect_to login_path
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :password, :favourite_color, :admin)
    end
end
