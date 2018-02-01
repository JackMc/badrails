class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to controller: :blogs, action: :index
    else
      flash.alert = "Errors: #{@user.errors.full_messages.to_sentence}"
      redirect_to action: "new"
    end
  end

  def login
    if session[:user_id]
      redirect_to controller: :blogs, action: :index
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to action: :login
  end

  def do_login
    @user = User.find_by(name: user_params[:name])
    if @user&.log_in(user_params[:password])
      session[:user_id] = @user.id
      redirect_to controller: :blogs, action: :index
    else
      flash.alert = "Name or password not found."
      redirect_to "/login"
    end

  rescue ActiveRecord::RecordNotFound
    flash.alert = "Name or password not found."
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :password, :favourite_color)
    end

    def login_params
      params.require(:user).permit(:name, :password)
    end
end
