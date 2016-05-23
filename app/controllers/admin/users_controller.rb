class Admin::UsersController < Admin::ApplicationController

  def index
    @page_title = 'admin users'
    if params[:search]
    @users = User.search(params[:search]).all.order('name ASC').paginate(:per_page => 10, :page => params[:page])
    else
    @users = User.all.order('name ASC').paginate(:per_page => 10, :page => params[:page])
    end
  end

  def new
    page_title = 'Add User'
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save 
      flash[:notice] = 'Created a new user successfully' 
      redirect_to admin_users_path
    else
      flash[:alert] = 'Failed creation of a new user' 
      render 'new'
    end
  end

  def edit
    page_title = 'Edit User'
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    flash[:notice] = 'Updated user successfully' 
      redirect_to admin_users_path
    else
      flash[:alert] = 'Failed user updated' 
      render 'edit'
    end  
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = 'User removed'
      redirect_to admin_users_path
    else
      render 'index'
    end
  end

private
  def user_params
    params.require(:user).permit(:name,:email,:password)
  end

end
