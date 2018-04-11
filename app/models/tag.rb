class Tag < ActiveRecord::Base 
	# Associations
	has_many :journal_tags

	# Validations
	validates :name, presence: true, uniqueness: true

	# WHERE scopes
	scope :by_name, -> (name) { where(name: name) }

	# ORDER scopes
	scope :order_by_name_asc, -> { order('name ASC') }
end
