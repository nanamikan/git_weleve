class CreateApplies < ActiveRecord::Migration[5.2]
  def change
    create_table :applies do |t|
      t.references  :student,  index: true, foreign_key: true
      t.references  :event, index: true, foreign_key: true
      t.bigint :student_id
      t.bigint :event_id
      t.timestamps
    end
  end
end
