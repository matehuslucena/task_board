class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :priority
      t.integer :status_id

      t.timestamps null: false
    end
  end
end
