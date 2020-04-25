class Event < ApplicationRecord
  # attr_accessor :group_id
  has_one_attached :image 
  has_many :applies, dependent: :destroy
  has_many :students, through: :applies
  # accepts_nested_attributes_for :appresence: true
  validates_presence_of  :title,:image,:date,:descrip, :where,:group_id
  
  # whereは20字
  validates :where, length: { maximum: 20 }     
  # descripは40字
  validates :descrip, length: { maximum: 40 } 
  
  belongs_to :group
  
end