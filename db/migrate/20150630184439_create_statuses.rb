class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string :name
      t.integer :task_id

      t.timestamps null: false
    end
  end
end
