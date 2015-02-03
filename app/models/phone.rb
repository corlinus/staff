class Phone < ActiveRecord::Base
	belongs_to :employee
	validates :number, presence: true
	validates_format_of :number, with: /\+7\s?\(\d{3}\)\s?\d{3}\-\d{2}\-\d{2}/
end
