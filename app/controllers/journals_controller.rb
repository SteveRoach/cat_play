class JournalsController < ApplicationController
	include JournalsHelper

	def new
		@journal = Journal.new

		@tags = Tag.order_by_name_asc
	end

	def create
		journal = Journal.new(user_params.merge({section_id: Section.journal.first.id}))
		journal.title.strip!
		journal.url.strip!

		tag_array = arrayify_tags(params[:tag_text])

		save_new_tags(tag_array)

		if journal.save
			link_tags_to_journal(journal.id, tag_array)

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
		
		if params[:id].nil?
			posted_date = Date.parse('01-01-1900')
		else
			posted_date = Journal.find(params[:id]).posted_date
		end

		@journals = Journal.after_posted_date(posted_date).order_by_posted_date_asc.paginate(page: params[:page], per_page: 10)

		@journal_array = []
		
		@journals.each do |journal|
			tags = Tag.joins(:journal_tags).merge(JournalTag.journal_id(journal.id)).order("name")

			csv_tags = csv_tags(tags)

			journal_hash = {:id=>journal.id, :title=>journal.title, :posted_date=>journal.posted_date, :url=>journal.url, :tags=>csv_tags}

			@journal_array.push(journal_hash)
		end
	end

	def destroy
		destroy_tag_links(params[:id])

		Journal.find(params[:id]).destroy

		flash[:success] = "Journal Entry deleted."

		redirect_to journals_path
	end

	def edit
		@journal = Journal.find(params[:id])

		tags = Tag.joins(:journal_tags).merge(JournalTag.journal_id(@journal.id)).order("name")

		@tag_string = csv_tags(tags)

		@all_tags = Tag.order('name ASC')
	end

	def update
		params[:journal][:title].strip!
		params[:journal][:url].strip!
		
		@journal = Journal.find(params[:id])

		destroy_tag_links(@journal.id)

		tag_array = params[:tag_text].split(",")

		tag_array.each do |submitted_tag|
			submitted_tag.strip!

			unless Tag.exists?(name: submitted_tag)
				Tag.new(name: submitted_tag).save
			end
		end

		if @journal.update_attributes(user_params)
			tag_array.each do |submitted_tag|
				submitted_tag.strip!

				tag = Tag.by_name(submitted_tag).first
				JournalTag.new(journal_id: @journal.id, tag_id: tag.id).save
			end

			flash[:success] = "Journal Entry updated."
			redirect_to journals_path(:id => params[:id])
		else
			tags = Tag.joins(:journal_tags).merge(JournalTag.journal_id(@journal.id)).order("name")

			@tag_string = csv_tags(tags)

			@all_tags = Tag.order('name ASC')

			render 'edit'
		end
	end

	def search
		@tags = Tag.order('name ASC')
	end

	def search_result
		if ! params[:search_criteria].nil?
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
				if params[:search_criteria][:logic_operation] == "1"
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
		end
			
		tag1_array = []

		if tag1 != 0
			tag1_list = JournalTag.tag_id(tag1)

			tag1_list.each do |t|
				tag1_array.push(t.journal_id)
			end
		end

		tag2_array = []

		if tag2 != 0
			tag2_list = JournalTag.tag_id(tag2)

			tag2_list.each do |t|
				tag2_array.push(t.journal_id)
			end
		end

		if logic_operation == "AND"
			result_array = tag1_array & tag2_array
		else
			result_array = tag1_array | tag2_array
		end

		if result_array.empty?
			@journals = Journal.ilike_title(title).between_posted_dates(from_date, to_date).order_by_posted_date_asc.paginate(page: params[:page], per_page: 10)
		else
			@journals = Journal.ilike_title(title).between_posted_dates(from_date, to_date).id_in(result_array).order_by_posted_date_asc.paginate(page: params[:page], per_page: 10)
		end

		if @journals.count == 0
			flash.now[:warning] = "No Journal Entries found for that criteria."
		else
			@journal_array = []

			@journals.each do |journal|

				tags = Tag.joins(:journal_tags).merge(JournalTag.journal_id(journal.id)).order("name")

				tag_string = csv_tags(tags)

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
