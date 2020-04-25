require 'rails_helper'

RSpec.describe "Applies", type: :request do
  # applyはuserが入力する欄はないので入力値テストは必要なし
  describe "GET#new" do
    
    context "as an authenticated user" do
      
      before do
        @student=create(:student)
        @event=create(:event)
      end
      
      it "responds successfully" do
        sign_in @student
        get :new
        expect(response).to be_success
      end
      
      it "returns a 200 response" do
        sign_in @student
        get :new
        expect(response).to have_http_status "200"
      end
      
    end
    
    context "as a guest" do
       it "returns a 302 response" do
        get :new
        expect(response).to have_http_status "302"
      end
      
      it "redirects to the sign_in page" do
        get :new
        expect(response).to redirect_to "/students/sign_in"
      end
    end
    
    
  # applyした本人のみがdestoryできる
  describe 'GET #delete_confirm' do
    context 'as an authorized user' do
      before do
        @student=create(:student,:with_apply)
      end
        
      it "responds successfully" do
        sign_in @student
        get :new
        expect(response).to be_success
      end
      
      it "returns a 200 response" do
        sign_in @student
        get :new
        expect(response).to have_http_status "200"
      end
     end
     
     context "as unauthorized user" do
       it "responses a 302 response" do
         et :new
        expect(response).to have_http_status "302"
       end
       it "redirects to student's #show"do
       end
       
     end
     
     context "as a guest" do
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
  
  describe 'POST #create' do
    context 'as an authorized user' do
      before do
        @student=create(:student,:with_group)
      end
      
      it "creates an apply"do
        apply_params=attributes_for(:apply)
        sign_in @student
        expect{
          post :create,params: { apply: apply_params}
        }.to change(@student.applies, :count)
      end
       
    end
     
    context "as unauthorized user" do
      before do
        @another_student=create(:student)
      end
      it "can not create an apply"do
         apply_params=attributes_for(:apply)
        sign_in @student
        # @studentとしてサインインしているのにanother_studentの応募を勝手に
        # しようとするとできない
        expect{
          post :create,params: { apply: apply_params,student_id: another_student.id}
        }.to not_change(@student.reload.applies, :count)
      end
       
      it "redirects to student's #show"do
        get :new
        expect(response).to redirect_to controller: 'students', action: 'show', id: student.id
      end
       
     end
     
    context "as a guest" do
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
  
    
  describe 'DESTROY #destroy' do
    context 'as an authorized user' do
      before do
          @student=create(:student,:with_group)
      end
        
      it "destories an apply"do
      end
    end
     
    context "as unauthorized user" do
        it "does not delete an apply"do
        end
        
        it "redirects to student's #show"do
           get :new
        expect(response).to redirect_to controller: 'students', action: 'show', id: student.id
        end
       
     end
     
    context "as a guest" do
      it "responses a 302 response" do
          get :new
        expect(response).to have_http_status "302"
      end
        
      it "redirects to sign_in_page" do
        get :new
        expect(response).to redirect_to "/students/sign_in"
      end
      #destoryの時だけ「destoryできない」ことを確認する
      it "does not delete an apply"do
      end
       
     end
     
   end
  
    
    
  end

end
