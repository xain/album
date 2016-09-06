class Photo < ActiveRecord::Base
	has_and_belongs_to_many :tags, -> { uniq }
	has_attached_file :file, styles: { thumb: "220x310>" }
	validates_attachment_content_type :file, content_type: /\Aimage\/.*\z/

	def tag_list
		rlt = tags.collect {|t| t.name}.join(' ') 
		rlt = ' - ' if rlt.blank?
		return rlt
	end

	def tag_list=(val)
		self.tags = []
		val.strip.split(' ').each do |tag_name|
			next if tag_name == '-'
			tag = Tag.find_or_create_by(name: tag_name)
			self.tags << tag
		end
	end

end
