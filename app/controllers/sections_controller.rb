class SectionsController < ApplicationController

  before_action :logged_in_user, only: [:new, :create, :index, :destroy]

  def new
  	@section = Section.new
  end

  def create
  	@section = Section.new(user_params)

  	if @section.save
  		flash[:success] = "New Section saved."
  		redirect_to new_section_path
  	else
  		render 'new'
  	end
  end

  def index
  	if not Section.exists?
  		flash.now[:warning] = "No Sections found."
  	end
    
  	@sections = Section.paginate(page: params[:page], per_page: 10)
  end

  def destroy
  	Section.find(params[:id]).destroy
  	flash[:success] = "Section deleted."
  	redirect_to sections_path
  end

  private

  	def user_params
  		params.require(:section).permit(:name)
  	end

    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end
