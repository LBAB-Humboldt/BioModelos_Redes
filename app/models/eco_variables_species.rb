class EcoVariablesSpecies < ActiveRecord::Base
	validates_inclusion_of :min, in: 0..1
	validates_inclusion_of :max, in: 0..1
	validates_inclusion_of :mean, in: 0..1
	validates_inclusion_of :certainty, in: 0..1
end