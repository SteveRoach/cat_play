class JournalsController < ApplicationController

  def new
  	@journal = Journal.new
  end

  def create
  	@section = Section.find_by(name: "Journal")

  	@journal = Journal.new(user_params.merge({section_id: @section.id}))

  	if @journal.save
  		flash[:success] = "New Journal Entry saved."
  		redirect_to new_journal_path
  	else
  		render 'new'
  	end
  end

  def index
  	if not Journal.exists?
  		flash.now[:warning] = "No Journal Entries found."
  	end
    
  	@journals = Journal.order('posted_date ASC').paginate(page: params[:page], per_page: 10)
  end

  def destroy
  	Journal.find(params[:id]).destroy
  	flash[:success] = "Journal Entry deleted."
  	redirect_to journals_path
  end

  private

  	def user_params
  		params.require(:journal).permit(:title, :posted_date, :url)
  	end

    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end
