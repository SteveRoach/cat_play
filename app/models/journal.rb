class Journal < ActiveRecord::Base
	belongs_to :section, required: true
	has_many :journal_tags

  	validates :title,  presence: true
  	validates :posted_date, presence: true
  	validates :url, presence: true
end
