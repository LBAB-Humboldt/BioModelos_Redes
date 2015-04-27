class Rating < ActiveRecord::Base

	belongs_to :models
	belongs_to :users

	def rating_exists(model_id, user_id)
		exists?(":model_id = ? and :user_id = ?", "#{model_id}", "#{user_id}")
	end 

end
