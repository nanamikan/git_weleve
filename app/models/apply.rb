class Apply < ApplicationRecord
  belongs_to :event
  belongs_to :student
  validates :student_id,:event_id, uniqueness: true
end


