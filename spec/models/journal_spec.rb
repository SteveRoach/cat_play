require 'rails_helper'

describe Journal, type: :model do
	describe "Validations" do
		context "validates :title" do
			it { should validate_presence_of(:title) }
		end

		context "validates :posted_date" do
			it { should validate_presence_of(:posted_date) }
		end

		context "validates :url" do
			it { should validate_presence_of(:url) }
		end

	end

	describe "WHERE scopes" do
		context "scope :by_section_id" do
			before do
				create(:section, :journal)
				@journal_section_id = Section.journal[0].id
				@a = create(:journal, section_id: @journal_section_id)
				@b = create(:journal)
				@c = create(:journal, section_id: @journal_section_id)
				@d = create(:journal)
				@e = create(:journal, section_id: @journal_section_id)
			end

			it "should return the rows identified by the section_id" do
				expect(Journal.by_section_id(@journal_section_id)).to eq [@a, @c, @e]
			end

		end

		context "scope :after_posted_date" do
			before do
				@a = create(:journal, :after_now)
				@b = create(:journal, :before_now)
				@c = create(:journal, :after_now)
				@d = create(:journal, :before_now)
				@e = create(:journal, :after_now)
			end

			it "should return the rows with posted_date after given date" do
				expect(Journal.after_posted_date(Date.today)).to eq [@a, @c, @e]
			end

		end

		context "scope :ilike_title" do
			before do
				@a = create(:journal)
				@b = create(:journal, title: "TITLE")
				@c = create(:journal)
				@d = create(:journal, title: "Title")
				@e = create(:journal)
				@f = create(:journal, title: "Title")
				@g = create(:journal)
			end

			it "should return the rows with title LIKE given title - not case sensitive" do
				expect(Journal.ilike_title("title")).to eq [@b, @d, @f]
			end

		end

		context "scope :between_posted_dates" do
			before do
				@a = create(:journal, :before_a_week)
				@b = create(:journal, :within_a_week_either_way)
				@c = create(:journal, :after_a_week)
				@d = create(:journal, :within_a_week_either_way)
				@e = create(:journal, :before_a_week)
			end

			it "should return the rows with posted_date between given dates" do
				expect(Journal.between_posted_dates(Date.today - 7, Date.today + 7)).to eq [@b, @d]
			end

		end

	end

end
