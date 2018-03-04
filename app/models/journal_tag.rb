class JournalTag < ActiveRecord::Base
	belongs_to :journal
	belongs_to :tag

    validates :journal_id, :tag_id, presence: true, uniqueness: true
end 
