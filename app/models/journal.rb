class Journal < ActiveRecord::Base
	# Associations
	belongs_to :section, required: true
	has_many :journal_tags

	# Validations
  	validates :title,  presence: true
  	validates :posted_date, presence: true
  	validates :url, presence: true

	# WHERE scopes
	scope :by_section_id, -> (section_id) { where(section_id: section_id) }
	scope :after_posted_date, -> (posted_date) { where('posted_date >= ?', posted_date) }
	scope :ilike_title, -> (title) { where('title ILIKE ?', title)}
	scope :between_posted_dates, -> (start_date, end_date) { where('journals.posted_date BETWEEN ? AND ?', start_date, end_date)}
	scope :id_in, -> (id_array) { where('id in (?)', id_array)}

	# ORDER scopes
	scope :order_by_posted_date_asc, -> { order('posted_date ASC') }
end
