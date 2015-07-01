class AddPublicToBoard < ActiveRecord::Migration
  def change
    add_column :boards, :public, :boolean
  end
end
