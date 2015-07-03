class Task < ActiveRecord::Base
  	
  	validates_presence_of :title, :priority, :status_id, :board_id

	belongs_to :board
	belongs_to :status
	belongs_to :user




end
