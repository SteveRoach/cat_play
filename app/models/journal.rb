class Journal < ActiveRecord::Base
	belongs_to :section, required: true
	has_many :journal_tags

  	validates :title, :posted_date, :url, presence: true
end
