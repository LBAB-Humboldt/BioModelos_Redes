class WorkshopTest < ActiveRecord::Base
	validates_inclusion_of :min_ocurrence, in: 0..1
	validates_inclusion_of :max_ocurrence, in: 0..1
	validates_inclusion_of :best_prob_ocurrence, in: 0..1
	validates_inclusion_of :certainty_true_value, in: 0.5..1
end