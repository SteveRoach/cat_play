class JournalsController < ApplicationController

  def new
  	@journal = Journal.new

  	@tags = Tag.order('name ASC')
  end

  def create
  	@section = Section.find_by(name: "Journal")

  	@journal = Journal.new(user_params.merge({section_id: @section.id}))
  	@journal.title.strip!
  	@journal.url.strip!

  	@submitted_tag_string = params[:tag_text]

  	@submitted_tag_array = @submitted_tag_string.split(",")

  	@submitted_tag_array.each do |submitted_tag|
  		submitted_tag.strip!

  		unless Tag.exists?(name: submitted_tag)
  			@new_tag = Tag.new(name: submitted_tag)
  			@new_tag.save
  		end
  	end


  	if @journal.save
	  	@submitted_tag_array.each do |submitted_tag|
	  		submitted_tag.strip!
	  		@existing_tag = Tag.find_by(name: submitted_tag)
	  		@new_journal_tag = JournalTag.new(journal_id: @journal.id, tag_id: @existing_tag.id)
	  		@new_journal_tag.save
	  	end

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
    
  	@journal_array = []

  	@journals = Journal.order('posted_date ASC').paginate(page: params[:page], per_page: 10)

  	@journals.each do |journal|
  		tag_string = ""

  		@tags = Tag.joins(:journal_tags).where("journal_tags.journal_id = ?", journal.id).select("name").order("name")

  		@tags.each do |tag|
  			tag_string = tag_string + tag.name

  			unless tag == @tags.last
  				tag_string = tag_string + ", "
  			end
  		end

  		journal_hash = {:id=>journal.id, :title=>journal.title, :posted_date=>journal.posted_date, :url=>journal.url, :tags=>tag_string}

		  @journal_array.push(journal_hash)
  	end

  end

  def destroy
  	Journal.find(params[:id]).destroy
  	flash[:success] = "Journal Entry deleted."
  	redirect_to journals_path
  end

  def edit
    @journal = Journal.find(params[:id])

    @tags = Tag.joins(:journal_tags).where("journal_tags.journal_id = ?", @journal.id).select("name").order("name")

    @tag_string = ""

    @tags.each do |tag|
      @tag_string = @tag_string + tag.name

      unless tag == @tags.last
        @tag_string = @tag_string + ", "
      end
    end

    @all_tags = Tag.order('name ASC')
end

  def update
    params[:journal][:title].strip!
    params[:journal][:url].strip!
    @journal = Journal.find(params[:id])

    @current_tag_links = JournalTag.where("journal_tags.journal_id = ?", @journal.id)

    @current_tag_links.each do |current_tag_link|
      current_tag_link.destroy
    end

    @submitted_tag_string = params[:tag_text]

    @submitted_tag_array = @submitted_tag_string.split(",")

    @submitted_tag_array.each do |submitted_tag|
      submitted_tag.strip!

      unless Tag.exists?(name: submitted_tag)
        @new_tag = Tag.new(name: submitted_tag)
        @new_tag.save
      end
    end

    if @journal.update_attributes(user_params)
      @submitted_tag_array.each do |submitted_tag|
        submitted_tag.strip!
        @existing_tag = Tag.find_by(name: submitted_tag)
        @new_journal_tag = JournalTag.new(journal_id: @journal.id, tag_id: @existing_tag.id)
        @new_journal_tag.save
      end

      flash[:success] = "Journal Entry updated."
      redirect_to journals_path
    else
      render 'edit'
    end
  end

  private

  	def user_params
  		params.require(:journal).permit(:title, :posted_date, :url, :tag_text)
  	end

    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end
