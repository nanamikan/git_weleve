require 'rails_helper'

RSpec.feature "signin and signout" do
 
  scenario 'signin and out' do
    # student = create(:student)
    # visit  new_student_session_path
    # fill_in 'email', with: student.email
    # fill_in 'password', with: student.password
    # Gem Deviseを利用しているので下省略して下記のように書ける
    student=create(:student)
    login_as(student, :scope => :student, :run_callbacks => false)
    # select 1, from: '学年'
    # click_link リンクをクリック
    # click_on リンクかボタンか考えたくない時⇐便利
    # expect(page).to have_content "ログインしました。"
    logout(:user)
  end
  
end