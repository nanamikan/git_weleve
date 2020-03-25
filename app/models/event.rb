class Event < ApplicationRecord
  # attr_accessor :group_id
  has_one_attached :image 
  has_many :applies, dependent: :destroy
  has_many :students, through: :applies
  # accepts_nested_attributes_for :appresence: true
  validates_presence_of :date, :title, :where, :image
  
  belongs_to :group
  
end
