class JournalsController < ApplicationController
  load_and_authorize_resource param_method: :journals_params
  before_action :set_journal, except: [:new, :index, :create]

  def index
    @journals = Journal.all
  end

  def new
    @journal = Journal.new
  end

  def create
    @journal = Journal.new(journals_params)

    if @journal.save
      redirect_to journals_path, notice: "Journals created successfully."
    else
      redirect_to journals_path, alert: "Some thing went wrong, Please try again later."
    end
  end

  def edit; end

  def update
    if @journal.update(journals_params)
      redirect_to journals_path, notice: "Journals updated successfully."
    else
      redirect_to journals_path, alert: "Some thing went wrong, Please try again later."
    end
  end

  def destroy
    if @journal.destroy
      redirect_to journals_path, notice: "Journals destroyed successfully."
    else
      redirect_to journals_path, alert: "Some thing went wrong, Please try again later."
    end
  end

  private

  def set_journal
    @journal = Journal.find(params[:id])
  end

  def journals_params
    params.require(:journal).permit(:title, :volume, :issue, :language, :publish_year, :publisher, :description, :categories)
  end
end
