require 'rails_helper'

RSpec.describe "Students", type: :request do
 
  describe 'GET#edit' do
      
    context 'as an authorized user' do
      
      before do
        @student=create(:student)
      end
      
      it "responses successfully" do
        
      end
      
      it "responses a 200 response" do
      end
      
    end

      
    context 'as an unauthorized_student' do
      
      it "responses a 302 response" do
      end
      
      it "redirects to student's #show" do
      end
      
    end
    
    context "as a guest" do
      it "responses a 302 response" do
        get :new
        expect(response).to have_http_status "302"
        end
      end
        
      it "redirects to sign_in_page" do
        get :new
        expect(response).to redirect_to "/students/sign_in"
      end
      
     end
      
  end
    
   
  describe 'PATCH#update' do
      
      # ログインしてるユーザーなら情報をupdateできる
    context 'as an authorized user' do
        
      before do
        @student=create(:student)
      end
      
       #有効な属性値の場合
      context "with valid attributes" do
         it "updates a student"do
          student_params=attributes_for(:student, name: "update")
          sign_in @student
          post :update, params:{ student: student_params, group_id: @student.groups.first.id}
          expect (@student.name).to eq "update"
           
        end
      end
      
      #無効な属性値の場合
      context "with invalid attributes" do
        it "doesn't update a student"do
          student_params=attributes_for(:student,:invalid_student)
          sign_in @student
          post :update, params:{ student: student_params}
          # @eventのdateは有効な値だが、event_paramsのdateは無効
          expect (@student.name).to eq "abc"
        end
      end
    end
    
    # ログインしてないユーザーなら情報をupdateできん
    context 'as a guest' do
    
      before do
        @student=create(:student)
      end
    
      it "responses a 302 response" do
        get :new
        expect(response).to have_http_status "302"
      end
        
      it "redirects to sign_in_page" do
        get :new
        expect(response).to redirect_to "/students/sign_in"
      end
    
    end
      
  end 
    
    
end
