class Species < ActiveRecord::Base
	
	has_many :models
	acts_as_commentable

	def self.search(query, classId)
		where("sci_name like ? and class_id = ?", "%#{query}%", "#{classId}").limit(10)
	end

end
