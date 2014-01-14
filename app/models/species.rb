class Species < ActiveRecord::Base
	has_many :models

	def self.search(query, classId)
		where("sci_name like ? and class_id = ?", "%#{query}%", "#{classId}").limit(10)
	end

end
