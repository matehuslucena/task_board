json.array!(@tasks) do |task|
  json.extract! task, :id, :title, :priority, :status_id
  json.url task_url(task, format: :json)
end
