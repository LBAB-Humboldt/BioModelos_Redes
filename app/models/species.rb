class Species < ActiveRecord::Base
	has_many :models

	def self.search(query)
		where("sci_name like ?", "%#{query}%").limit(10)
	end

end
