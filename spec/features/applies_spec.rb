require 'rails_helper'

RSpec.feature "Applies", type: :feature do
   include LoginSupport
  pending "add some scenarios (or delete) #{__FILE__}"
  
  # ログインしてるstudentでそのイベントに対してまだapplyしてない時
   scenario "an authorized student create an apply" do
     event=create(:event)
     student=create(:student)
     sign_in_as(student)
     
     expect{
     click_link "参加する"
     visit new_event_apply_path
     click_link "はい"
       
     }.to change(student.applies.first, :count).by(1)
   end
   
   
   # ログインしてるstudentが他のstudentのapplyしようとしてもできない
  #  追加する時のパスは /events/#{event.id}/applies/new なので
    # 他人のapplyをcreateするパスは存在せん(student_idは現在ログイン中のstudentの値に)
     
   scenario "an unauthorized student doesn't create an apply" do
     event=create(:event)
     student=create(:student)
     another_student=build(:student)
     sign_in_as(another_student)
     expect{
     visit "/events/#{event.id}/applies/new"
     click_link "応募する"
     }.to not_change(student.applies.first, :count)
   end
   
   
    scenario "an authorized student destroies an apply" do
     event=create(:event)
     student=create(:student)
     apply=create(:apply, student_id: student.id, event_id: event.id)
     sign_in_as(student)
     
     expect{
     click_link "キャンセルする"
     visit "/applies/#{apply.id}/events/#{event.id}/delete"
     click_link "はい"
     }.to change(student.applies.first, :count).by(-1)
   end
   
   
    scenario "an unauthorized student doesn't destroy an apply" do
     event=create(:event)
     student=create(:student)
     another_student=build(:student)
     apply=create(:apply, student_id: student.id, event_id: event.id)
     
     sign_in_as(another_student)
     
     expect{
     click_link "キャンセルする"
     visit "/applies/#{apply.id}/events/#{event.id}/delete"
     click_link "はい"
     }.to not_change(student.applies.first, :count)
   end
   
   
end
