module LoginSupport
  
  def sign_in_as(student)
     # studentログイン
    visit  new_student_session_path
    save_and_open_page
    fill_in "Email", with: student.email 
    fill_in "Passwsord", with: student.password
    click_button "ログイン"
    visit root_path
  end
end