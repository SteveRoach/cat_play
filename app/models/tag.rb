class Tag < ActiveRecord::Base 
	has_many :journal_tags

	validates :name, presence: true, uniqueness: true
end
