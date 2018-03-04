class Section < ActiveRecord::Base
	has_many :journals

	validates :name, presence: true, uniqueness: true
end
