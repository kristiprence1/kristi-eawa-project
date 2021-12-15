class BooksController < ApplicationController
  load_and_authorize_resource  param_method: :books_params
  before_action :set_book, except: [:new, :index, :create]

  def index
    @books = Book.all
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(books_params)

    if @book.save
      redirect_to books_path, notice: "Books created successfully."
    else
      redirect_to books_path, alert: "Some thing went wrong, Please try again later."
    end
  end

  def edit; end

  def update
    if @book.update(books_params)
      redirect_to books_path, notice: "Books updated successfully."
    else
      redirect_to books_path, alert: "Some thing went wrong, Please try again later."
    end
  end

  def destroy
    if @book.destroy
      redirect_to books_path, notice: "Books destroyed successfully."
    else
      redirect_to books_path, alert: "Some thing went wrong, Please try again later."
    end
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def books_params
    params.require(:book).permit(:title, :author, :language, :publisher, :publish_year, :description, :categories, :volume)
  end
end
