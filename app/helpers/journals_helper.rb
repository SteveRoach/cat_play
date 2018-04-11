module JournalsHelper
	def arrayify_tags(tag_csv)
		tag_array = tag_csv.split(",") - [""]
	end

	def csv_tags(tag_arel)
		tag_csv = ""

		tag_arel.each do |tag|
			tag_csv = tag_csv + tag.name

			unless tag == tag_arel.last
				tag_csv = tag_csv + ", "
			end
		end

		return tag_csv
	end

	def save_new_tags(tag_array)

		tag_array.each do |tag|
			tag.strip!

			unless Tag.exists?(name: tag)
				Tag.new(name: tag).save
			end
		end
	end

	def link_tags_to_journal(journal_id, tag_array)

		tag_array.each do |tag|
			tag.strip!
			tag_id = Tag.find_by(name: tag).id
			journal_tag = JournalTag.new(journal_id: journal_id, tag_id: tag_id)
			journal_tag.save
		end
	end

	def destroy_tag_links(journal_id)
		tag_links = JournalTag.journal_id(journal_id)

		tag_links.each do |tag_link|
				tag_link.destroy
		end
	end
end
