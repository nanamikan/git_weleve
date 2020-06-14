class ChangeConnectionsToStudentGroup < ActiveRecord::Migration[5.2]
  def change
    rename_table :connections, :student_groups
  end
end
