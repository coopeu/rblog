class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

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
    #@user = User.new(user_params)
    @user = User.new(params[:user])
    
    respond_to do |format|
      if @user.save
#        UserMailer.welcome_email(@user).deliver_later
#        UserMailer.welcome_email(@user).deliver_now
        UserMailer.welcome_mail(@user).deliver_now
        Notifier.welcome(User.first).deliver_now # sends the email
        mail = Notifier.welcome(User.first)      # => an ActionMailer::MessageDelivery object
        mail.deliver_now                    # sends the email
        Notifier.welcome(@user).deliver  

        message = Notifier.welcome("consen@consen.org")   # => Returns a Mail::Message object
        message.deliver_now   # => delivers the email

        Notifier.welcome("consen@consen.org").deliver_now # Creates the email and sends it immediately

        UserNotifier.welcome_mail(@user).deliver_now
        UserNotifier.deliver_welcome_mail(@user)
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
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
      params.require(:user).permit(:name, :email, :login)
    end
end
