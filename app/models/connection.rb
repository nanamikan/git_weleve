class Connection < ApplicationRecord
  belongs_to :student
  belongs_to :group
  # studentが属するgroupは1つのみ
  validates :student_id, uniqueness: true
end
