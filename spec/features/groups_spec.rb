require 'rails_helper'

RSpec.feature "Groups", type: :feature do
  include LoginSupport
  pending "add some scenarios (or delete) #{__FILE__}"
  
  scenario "an authorized student updates the group" do
    student=create(:student,:with_group)
    group=student.groups.first
    sign_in_as(student)
    # groupログイン
    visit group_path
    click_link "グループアカウント"
    # profile editリンククリック
    click_link "group_event"
    expect{
      expect(page).to have_selector 'span', text: '名前'
      expect(page).to have_selector 'span', text: '分類'
      expect(page).to have_selector 'span', text: '活動'
      expect(page).to have_selector 'span', text: '紹介'
      
      fill_in "group_name", with: "new_name"
      fill_in "group_category", with: "サークル"
      fill_in "group_what_to_do", with: "aaa"
      fill_in "group_intro", with: "bbbbbbbbbb"
      
      click_button "保存"
    }
    # ちゃんとupdate出来てるか確認
    expect(group.reload.name).to eq "new_name"
  end
  
  
  scenario "an unauthorized student doesn't update the group" do
    student=create(:student)
    group=create(:group)
    
    sign_in_as(student)
    # groupログイン
    # editにアクセスできん
    # updateできないことを確認
    visit group_path
    group_params=attributes_for(:group)
    
    expect{
      visit root_path
          # @eventのdateは有効な値だが、event_paramsのdateは無効
    }
    expect (group.name).to eq "abc"
    
   
    # update出来てないか確認
    
    
  end
end
