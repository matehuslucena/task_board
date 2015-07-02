json.tasks @tasks do |task|
	json.title task.title
	json.priority task.priority
	json.status task.status.name
	json.board task.board.name
end
