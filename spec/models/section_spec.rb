require 'rails_helper'

describe Section, type: :model do
	describe "Associations" do
		context "has_many :journals" do
			it { should have_many(:journals) }
		end
	end

	describe "Validations" do
		context "validates :name" do
			before { @section = FactoryGirl.build(:section) }

			subject { @section }

			it { should validate_presence_of(:name) }
			it { should validate_uniqueness_of(:name) }
		end
	end

	describe "WHERE scopes" do
		context "scope :journal" do

			before do
				create(:section)
				@journal = create(:section, :journal)
				create(:section)
			end

			it "should return the name = 'Journal' row" do
				expect(Section.journal[0].name).to eq(@journal.name)
			end
		end

	end

	describe "ORDER scopes" do
		context "scope :order_by_name_asc" do

			before do
				@d = create(:section, :d_name)
				@b = create(:section, :b_name)
				@a = create(:section, :a_name)
				@c = create(:section, :c_name)
			end

			it "should order by name ASC" do
				expect(Section.order_by_name_asc).to eq [@a, @b, @c, @d]
			end
		end

	end

end
