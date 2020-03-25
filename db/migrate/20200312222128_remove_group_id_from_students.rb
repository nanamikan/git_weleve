class RemoveGroupIdFromStudents < ActiveRecord::Migration[5.2]
  def change
     remove_column :students, :group_id, :integer
  end
end
