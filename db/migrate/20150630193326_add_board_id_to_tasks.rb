class AddBoardIdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :board_id, :integer
  end
end
