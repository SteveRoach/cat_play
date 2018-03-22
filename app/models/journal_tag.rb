class JournalTag < ActiveRecord::Base
	belongs_to :journal
	belongs_to :tag

    validates :journal_id, presence: true
    validates :tag_id, presence: true
    validates :journal_id, uniqueness: { scope: :tag_id }
end
