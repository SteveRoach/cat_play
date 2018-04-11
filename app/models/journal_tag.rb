class JournalTag < ActiveRecord::Base
	# Associations
	belongs_to :journal
	belongs_to :tag

	# Validations
	validates :journal_id, presence: true
	validates :tag_id, presence: true
	validates :journal_id, uniqueness: { scope: :tag_id }

	# WHERE scopes
	scope :journal_id, -> (journal_id) { where(journal_id: journal_id) }
	scope :tag_id, -> (tag_id) { where(tag_id: tag_id) }

	# ORDER scopes
end
