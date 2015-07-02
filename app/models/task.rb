class Task < ActiveRecord::Base

	belongs_to :board
	belongs_to :status
	belongs_to :user

	validates :title, presence: true

end
