class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find(current_user.id)
    @book = Book.new
    @users = User.all.page(params[:page]).reverse_order
  end

  def show
    @book = Book.new
    @book_user = User.find(params[:id])
    @books = @book_user.books.page(params[:page]).reverse_order
  end

  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:update] = "You have updated user successfully"
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
