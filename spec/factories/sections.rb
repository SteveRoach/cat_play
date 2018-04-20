FactoryGirl.define do
	factory :section do
		sequence(:name) { |n| "#{Faker::Cat.name}#{n}" }

		trait :journal do
			name "Journal"
		end

		trait :a_name do
			sequence(:name) { |n| "a#{Faker::Cat.name}#{n}" }
		end

		trait :b_name do
			sequence(:name) { |n| "b#{Faker::Cat.name}#{n}" }
		end

		trait :c_name do
			sequence(:name) { |n| "c#{Faker::Cat.name}#{n}" }
		end

		trait :d_name do
			sequence(:name) { |n| "d#{Faker::Cat.name}#{n}" }
		end

	end

end
