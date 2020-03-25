class Group < ApplicationRecord
     # ユーザーのレコードと画像を紐づけることができます
     # ユーザーテーブルにカラムを追加する必要はありません。
         has_one_attached :image 
         
        # 親テーブルのデータが消えたら子テーブル(connections)のデータも消す
        has_many :connections, dependent: :destroy
        has_many :students, through: :connections
        accepts_nested_attributes_for :connections
        
        has_many :events, dependent: :destroy
        
        
         validates_presence_of :intro, :image, :category,:what_to_do
       
       def full_profile?
         name?&&category?&&what_to_do?&&intro?&&image.attached?  
       end
       
       
        # has_attached_file :icon,
        #              styles:  { medium: "100×100#", thumb: "100×100#" }
                     
        # validates_attachment_content_type :icon,
                    # content_type: ["image/jpg","image/jpeg","image/png"]
         
end
