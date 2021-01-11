class Setting < ApplicationRecord

	def self.current
		Setting.last.present? ? Setting.last : Setting.new
	end
end
