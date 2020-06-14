class StudentGroup < ApplicationRecord
  belongs_to :student
  belongs_to :group
  # 1人のstudentが属するgroupは1つのみ
  validates :student_id, uniqueness: true
end
