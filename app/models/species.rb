class Species < ActiveRecord::Base
	
	has_many :models
	has_and_belongs_to_many :groups
	acts_as_commentable

	def self.search(query, classId)
		where("sci_name like ? and class_id = ?", "%#{query}%", "#{classId}").limit(10)
	end

end
