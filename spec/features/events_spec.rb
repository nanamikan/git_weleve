require 'rails_helper'

RSpec.feature "Events", type: :feature do
  include LoginSupport
  # groupと紐づいているstudentはevent作成できる
  scenario "an authorized student creates a new event" do
    student=create(:student,:with_group)
    
    sign_in_as(student)
    
    # groupログイン
    visit group_path
    click_link "グループアカウント"
    
    # event作成リンククリック
    click_link "new_event"
    expect{
     
      expect(page).to have_selector 'span', text: '名前'
      expect(page).to have_selector 'span', text: '場所'
      expect(page).to have_selector 'span', text: '日時'
      expect(page).to have_selector 'span', text: '説明'
      
      fill_in "event_title", with: "aaa"
      fill_in "event_date", with: Date.today
      fill_in "event_where", with: "aaa"
      fill_in "event_descrip", with: "bbb"
      
      click_button "保存"
      
    }. to change(student.groups.first.events, :count).by(1)
    
  end
  
   # groupと紐づいてないstudentはevent作成できない
  scenario "an unauthorized student doesn't create a new event" do
    student=create(:student)
   
    sign_in_as(student)
    
    # groupログインはせず
    # event新規作成ページへ
   
    visit "/groups/1/events/new"
    expect{
      visit root_path
    }. to not_change(student.groups.first.events, :count).by(1)
    
 end
 
  scenario "an authorized student updates a new event" do
    student=create(:student,:with_group)
    event=create(:event, group_id: student.groups.first.id)
    
    sign_in_as(student)
    
    # groupログイン
    visit group_path
    click_link "グループアカウント"
    
    # event作成リンククリック
    click_link "edit_event"
    expect{
     
      expect(page).to have_selector 'span', text: '名前'
      expect(page).to have_selector 'span', text: '場所'
      expect(page).to have_selector 'span', text: '日時'
      expect(page).to have_selector 'span', text: '説明'
      
      fill_in "event_title", with: "aaa"
      fill_in "event_date", with: Date.today
      fill_in "event_where", with: "aaa"
      fill_in "event_descrip", with: "bbb"
      
      click_button "保存"
    } 
    expect(event.title).to eq "aaa"
    
  end
   scenario "student who doesn't associate with a group doesn't update a new event" do
    student=create(:student)
    event=create(:event, title: "can't update")
    
     sign_in_as(student)
   
    # event編集リンク
    click_link "/groups/2/events/event.id/edit"
    expect{
      visit root_path
    }. to (event.title).not_eq "can't update"
  end
 
# groupアカウントを持っているstudentでも
# eventのgroup_idとstudentのgroupアカウントが一致しなかったら
# updateできん
  scenario "an unauthorized_student doesn't update a new event" do
    student=create(:student,:with_group)
    event=create(:event)
    
    while  event.group_id == 
    student.groups.first.id do
       group_id {Faker::Number.between(from: 1, to: 100)}
    end
   
    sign_in_as(student)
    # event編集リンク
    visit "/groups/2/events/event.id/edit"
    expect{
      visit root_path
    }. to (event.title).eq "can't update"
  end
  
 
   scenario "an authorized student destroies an event" do
    student=create(:student,:with_group)
    event=create(:event, group_id: student.groups.first.id)
    
    sign_in_as(student)
    
    # groupログイン
    visit group_path
    click_link "グループアカウント"
  
    
    # eventdestroyリンククリック
    click_link "destroy_event"
    
     expect{
      visit "/groups/#{student.groups.first.id}/events/#{event.id}"
    }. to change(student.groups.first.events, :count).by(-1)
    
  end
  
   # groupアカウントを持っているstudentでも
# eventのgroup_idとstudentのgroupアカウントが一致しなかったら
# destroyできん
  scenario "an authorized student destroies an event" do
    student=create(:student,:with_group)
    event=create(:event)
    
    
    while  event.group_id == student.groups.first.id do
       group_id {Faker::Number.between(from: 1, to: 100)}
    end
     sign_in_as(student)
    # groupログイン
    visit group_path
    click_link "グループアカウント"
    
    # eventdestroyリンククリック
    click_link "destroy_event"
    
     expect{
      # リダイレクトされる
      visit root_path
    }. to not_change(student.groups.first.events, :count)
    
  end
  
 
end
