class BooksController < ApplicationController
  before_action :authenticate_user!, only: [:show, :index, :edit]

  def about
  end

  def top
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:create] = "Book was successfully created"
      redirect_to book_path(@book.id)
    else
      @user = User.find(current_user.id)
      @books = Book.all.page(params[:page]).reverse_order
      @newbook = @book
      render :index
    end
  end

  def index
    @user = User.find(current_user.id)
    @books = Book.all.page(params[:page]).reverse_order
    @newbook = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @newbook = Book.new
    @book_user = User.find(@book.user_id)
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user_id != current_user.id
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:update] = "Book was successfully updated"
      redirect_to book_path
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

end
