class Event < ApplicationRecord
  # attr_accessor :group_id
  has_one_attached :image 
  has_many :student_events, dependent: :destroy
  has_many :students, through: :student_events
  # accepts_nested_attributes_for :appresence: true
  # 画像はつけなくてもevent作成可能
  validates_presence_of  :title,:image,:date,:descrip, :where,:group_id
  # whereは20字
  validates :where, length: { maximum: 20 }     
  # descripは40字
  validates :descrip, length: { maximum: 50 } 
  
  belongs_to :group
  
  
end