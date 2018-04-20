FactoryGirl.define do
	factory :tag do
		sequence(:name) { |n| "#{Faker::Address.city}#{n}" }

		trait :fixed_name_Tag do
			name "Tag"
		end

		trait :a_name do
			sequence(:name) { |n| "a#{Faker::Address.city}#{n}" }
		end

		trait :b_name do
			sequence(:name) { |n| "b#{Faker::Address.city}#{n}" }
		end

		trait :c_name do
			sequence(:name) { |n| "c#{Faker::Address.city}#{n}" }
		end

		trait :d_name do
			sequence(:name) { |n| "d#{Faker::Address.city}#{n}" }
		end

	end

end
