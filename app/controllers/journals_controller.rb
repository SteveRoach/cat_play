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

		if params[:id].nil?
			@posted_date = Date.parse('01-01-1900')
		else
			@posted_date = Journal.where("id = ?", params[:id]).select("posted_date")
		end

		@journals = Journal.order('posted_date ASC').where("posted_date >= (?)", @posted_date).paginate(page: params[:page], per_page: 10)

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
			redirect_to journals_path(:id => params[:id])
		else
			@tags = Tag.joins(:journal_tags).where("journal_tags.journal_id = ?", @journal.id).select("name").order("name")

			@tag_string = ""

			@tags.each do |tag|
				@tag_string = @tag_string + tag.name

				unless tag == @tags.last
					@tag_string = @tag_string + ", "
				end
			end

			@all_tags = Tag.order('name ASC')

			render 'edit'
		end
	end

	def search
		@tags = Tag.order('name ASC')
	end

	def search_result
		if params[:search_criteria][:title].present?
			title = "%" + params[:search_criteria][:title] + "%"
		else
			title = String.new("%")
		end
		
		if params[:search_criteria][:from_date].present?
			from_date = params[:search_criteria][:from_date]
		else
			from_date = Date.new(1900,01,01)
		end

		if params[:search_criteria][:to_date].present?
			to_date = params[:search_criteria][:to_date]
		else
			to_date = Date.new(2500,01,01)
		end

		if params[:search_criteria][:tag1].present?
			tag1 = params[:search_criteria][:tag1]
		else
			tag1 = 0
		end
			
		if params[:search_criteria][:tag2].present?
			tag2 = params[:search_criteria][:tag2]
		else
			tag2 = tag1
		end

		if params[:search_criteria][:logic_operation].present?
			if params[:search_criteria][:logic_operation] == 1
				if tag1 == 0
					logic_operation = String.new("OR")
				else
					logic_operation = String.new("AND")
				end
			else
				logic_operation = String.new("OR")
			end
		else
			logic_operation = String.new("OR")
		end
			
logger.debug "vvvvvvvvvvvvvvv"
logger.debug title.inspect
logger.debug from_date.inspect
logger.debug to_date.inspect
logger.debug tag1.inspect
logger.debug logic_operation.inspect
logger.debug tag2.inspect
logger.debug "^^^^^^^^^^^^^^^"

		@journal_array = []

		@journals = Journal.joins(:journal_tags)
		@journals = @journals.where("journals.title ILIKE ?", title)
		@journals = @journals.where("journals.posted_date BETWEEN ? AND ?", from_date, to_date)
		@journals = @journals.paginate(page: params[:page], per_page: 10)

		if tag1 != 0 or tag2 != 0
			if logic_operation == "OR"
				@journals = @journals.where("journal_tags.tag_id = ? OR journal_tags.tag_id = ?", tag1, tag2)
			else
				@journals = @journals.where("journal_tags.tag_id = ? AND journal_tags.tag_id = ?", tag1, tag2)
			end
		end

		if @journals.count == 0
			flash.now[:warning] = "No Journal Entries found for that criteria."
		else
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
