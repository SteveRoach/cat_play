require 'rails_helper'

describe Tag, type: :model do
	describe "Associations" do
		context "has_many :journal_tags" do
			it { should have_many(:journal_tags) }
		end

	end

	describe "Validations" do
		context "validates :name" do
			it { should validate_presence_of(:name) }
			it { should validate_uniqueness_of(:name) }
		end

	end

	describe "WHERE scopes" do
		context "scope :by_name" do

			before do
				create(:tag)
				@fixed_name = create(:tag, :fixed_name_Tag)
				create(:tag)
			end

			it "should return the name = '<name>' row" do
				expect(Tag.by_name("Tag")[0].name).to eq (@fixed_name.name)
			end

		end

	end

	describe "ORDER scopes" do
		context "scope :order_by_name_asc" do

			before do
				@d = create(:tag, :d_name)
				@b = create(:tag, :b_name)
				@a = create(:tag, :a_name)
				@c = create(:tag, :c_name)
			end

			it "should order by name ASC" do
				expect(Tag.order_by_name_asc).to eq [@a, @b, @c, @d]
			end

		end

	end

end
