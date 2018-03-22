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

  	@tags = Tag.order(:name).paginate(page: params[:page], per_page: 10)
  end

  def destroy
    tag_usage_count = JournalTag.where("tag_id = ?", params[:id]).count

    if tag_usage_count == 0
      Tag.find(params[:id]).destroy
      flash[:success] = "Tag deleted."
    else
      flash[:danger] = "This Tag is linked to one or more Articles."
    end

    redirect_to tags_path
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])

    if @tag.update_attributes(user_params)
      flash[:success] = "Tag updated."

      redirect_to tags_path
    else
      render 'edit'
    end
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
