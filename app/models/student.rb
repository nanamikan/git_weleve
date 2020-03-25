class Student < ApplicationRecord
# ユーザーのレコードと画像を紐づけることができます
     # ユーザーテーブルにカラムを追加する必要はありません。
  has_one_attached :image 

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
 
  has_many :applies, dependent: :destroy
  has_many :events, through: :applies
  
  has_many :connections, dependent: :destroy
  has_many :groups, through: :connections
  accepts_nested_attributes_for :connections
#   accepts_nested_attributes_for というkeyは、
# 他のモデルを一括で更新、保存できるようにするもの

# なぜかわからんが作用しない↓
  validates_presence_of :intro, :image, :preference,:name,:grade
  # validates :email :password,:grade,:icon,:intro presence: true
  
  
  # 画像用のカラムのサイズやデフォルト画像、画像ファイルの保存先を設定できます。
#   has_attached_file :icon,
#                     styles:  { medium: "100×100#",thumb: "100×100#" }
                    
#                     # has_attached_file :カラム名,
#                     # styles:  { medium: "画像サイズ", thumb: "画像サイズ" }
  
#   # jpeg形式とpng形式を許可する場合
#   # 、画像のバリデーションを設定します。サイズや画像の種類でバリデーションが可能
#   validates_attachment_content_type :icon,
#                                     content_type: ["image/jpg","image/jpeg","image/png"]
# # rubyでは真偽値を返すメソッドには最後に?を付ける
    def full_profile?
      name?&&preference?&&intro?&&image.attached?  
    end
    
    

end
