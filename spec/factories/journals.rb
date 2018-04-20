FactoryGirl.define do
	factory :journal do
		title Faker::DrWho.specie
		posted_date Faker::Date.between(1.year.ago, 1.year.from_now)
		url Faker::Internet.url
		association :section, factory: [:section]

		trait :before_now do
			posted_date Faker::Date.between(1.year.ago, 1.day.ago)
		end

		trait :after_now do
			posted_date Faker::Date.between(Date.today, 1.year.from_now)
		end

		trait :within_a_week_either_way do
			posted_date Faker::Date.between(7.days.ago, 7.days.from_now)
		end

		trait :before_a_week do
			posted_date Faker::Date.between(1.year.ago, 8.days.ago)
		end

		trait :after_a_week do
			posted_date Faker::Date.between(8.days.from_now, 1.year.from_now)
		end

	end

end
