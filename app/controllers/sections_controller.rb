class SectionsController < ApplicationController

	before_action :logged_in_user, only: [:new, :create, :index, :destroy]

	def new
		@section = Section.new
	end

	def create
		if Section.new(user_params).save
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
		
		@sections = Section.ordered.paginate(page: params[:page], per_page: 10)
	end

	def destroy
		if Journal.section_id(params[:id]).count == 0
			Section.find(params[:id]).destroy
			flash[:success] = "Section deleted."
		else
			flash[:danger] = "This Section is linked to one or more Journal Entries."
		end

		redirect_to sections_path
	end

	def edit
		@section = Section.find(params[:id])
	end

	def update
		@section = Section.find(params[:id])

		if @section.update_attributes(user_params)
			flash[:success] = "Section updated."

			redirect_to sections_path
		else
			render 'edit'
		end
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
