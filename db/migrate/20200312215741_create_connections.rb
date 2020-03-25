class CreateConnections < ActiveRecord::Migration[5.2]
  def change
    create_table :connections do |t|
      t.references  :student,  index: true, foreign_key: true
      t.references  :group, index: true, foreign_key: true
      t.bigint :student_id
      t.bigint :group_id
      t.timestamps
    end
  end
end
