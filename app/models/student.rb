class Student < ApplicationRecord
# ユーザーのレコードと画像を紐づけ
  has_one_attached :avatar

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :applies, dependent: :destroy
  has_many :events, through: :applies
  
  has_many :connections, dependent: :destroy
  has_many :groups, through: :connections
  # 他のモデルを一括で更新、保存
  accepts_nested_attributes_for :connections
 
  validates :password, confirmation: true,on: :create
  validates :password_confirmation, presence: true,on: :create
  validates_presence_of  :password,:grade,:email,on: :create
  validates :intro,    length: { maximum: 60 }   
  
  def full_profile?
    name?&&preference?&&intro?&&avatar.attached?  
  end
end
