class TagsController < ApplicationController

  before_action :logged_in_user, only: [:new, :create, :index, :destroy]

  def new
  	@tag = Tag.new
  end

  def create
  	@tag = Tag.new(user_params)

  	if @tag.save
  		flash[:success] = "New Tag saved."
  		redirect_to new_tag_path
  	else
  		render 'new'
  	end
  end

  def index
  	if not Tag.exists?
  		flash.now[:warning] = "No Tags found."
  	end

  	@tags = Tag.paginate(page: params[:page], per_page: 10)
  end

  def destroy
  	Tag.find(params[:id]).destroy
  	flash[:success] = "Tag deleted."
  	redirect_to tags_path
  end

  private

  	def user_params
  		params.require(:tag).permit(:name)
  	end

    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end
