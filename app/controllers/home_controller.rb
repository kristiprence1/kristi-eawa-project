class HomeController < ApplicationController

  skip_before_action :authenticate_user!, only: [:index]

  def index
    @all_books = []

    if params[:search].present?
      if params[:resource_type].present?
        if params[:resource_type] == "All"
          Book.where("title ILIKE ?", "%#{params[:search]}%")&.each do |book|
            @all_books << book
          end
          Journal.where("title ILIKE ?", "%#{params[:search]}%").all&.each do |journal|
            @all_books << journal
          end
        elsif params[:resource_type] == "book"
          Book.where("title ILIKE ?", "%#{params[:search]}%")&.each do |book|
            @all_books << book
          end
        elsif params[:resource_type] == "journal"
          Journal.where("title ILIKE ?", "%#{params[:search]}%").all&.each do |journal|
            @all_books << journal
          end
        end
      else
        Book.where("title ILIKE ?", "%#{params[:search]}%")&.each do |book|
          @all_books << book
        end
        Journal.where("title ILIKE ?", "%#{params[:search]}%").all&.each do |journal|
          @all_books << journal
        end
      end
    else
      if params[:resource_type].present?
        if params[:resource_type] == "All"
          Book.all&.each do |book|
            @all_books << book
          end
          Journal.all&.each do |journal|
            @all_books << journal
          end
        elsif params[:resource_type] == "book"
          Book.all&.each do |book|
            @all_books << book
          end
        elsif params[:resource_type] == "journal"
          Journal.all&.each do |journal|
            @all_books << journal
          end
        end
      else
        Book.all&.each do |book|
          @all_books << book
        end
        Journal.all&.each do |journal|
          @all_books << journal
        end
      end
    end

    respond_to do |format|
      format.html
      format.json
      format.xml { render :xml => @all_books}
    end
  end

  def reservations
    @reservations = current_user.reservations
  end

  def my_loans
    @my_loans = current_user.loans
  end
end
