class Model < ActiveRecord::Base

	validates :species_id, :presence => true
    validates :img_url, :presence => true #, format:  { 	with: /((?:https?\:\/\/|www\.)(?:[-a-z0-9]+\.)*[-a-z0-9]+.*)/i,
    # 												message: "only allows valid urls" }
    validates :model_date, :presence => true
    validates :rating, inclusion: { in: 0..9 }

	has_many :reviews

	def self.search(query)
		where(":species_id like ?", "%#{query}%")
	end


end
