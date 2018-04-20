class Section < ActiveRecord::Base
	# Associations
	has_many :journals

	# Validations
	validates :name, presence: true, uniqueness: true

	# WHERE scopes
	scope :journal, -> { where(name: "Journal") }

	# ORDER scopes
	scope :order_by_name_asc, -> { order('name ASC') }
end
