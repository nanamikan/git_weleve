require 'rails_helper'
  describe GroupsController ,type: :controller do
    describe 'GET#edit' do
      # groupと紐づいているstudentならgroupの編集画面を表示できる
      context 'as an authorized user' do
        
        before do
          @student=create(:student,:with_group)
        end
        
        it "responds successfully" do
          get :new
          expect(response).to be_success
        end
      
        it "returns a 200 response" do
          get :new
          expect(response).to have_http_status "200"
        end
        
      end
      
      # groupと紐づいてないstudentならgroupの編集画面を表示できん
      context 'as an unauthorized user' do
        
        before do
          @student=create(:student,:with_group)
        end
        
       it "responses a 302 response" do
        get :new
        expect(response).to have_http_status "302"
       end
        
        it "redirects to student's #show" do
          get :new
          expect(response).to redirect_to controller: 'students', action: 'show', id: student.id
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
    
    describe 'PATCH #update' do
      context 'as an authorized user' do
        
        before do
          @student=create(:student,:with_group)
        end
        
        
        #有効な属性値の場合
        context "with valid attributes" do
          it "updates a group"do
           
            group_params=attributes_for(:group, name: "update")
            sign_in @student
            # グルアカとしてサインイン
            post :update, params:{ group: group_params}
            expect (@student.groups.first.name).to eq "update"
        end
      
        #無効な属性値の場合
        context "with invalid attributes" do
          it "doesn't update a group"do
            group_params=attributes_for(:group, :invalid)
            sign_in @student
            # グルアカとしてサインイン
            post :update, params:{ group: group_params}
            expect (@student.groups.first.name).to eq "abc"
          end
        end
        
      end
      
      # groupと紐づいてないstudentならgroupのupdateできん
      context 'as an unauthorized user' do
        
        before do
          @student=create(:student)
        end
        
       
        it "cannot update a group" do
          group_params=attributes_for(:group, :invalid)
            sign_in @student
            # グルアカとしてサインイン
            post :update, params:{ group: group_params}
            expect (@student.groups.first.name).to eq "abc"
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
    
    
  
    # describe 'GET #show' do
      
    #   it "assigns the requested contact to @group" do
    #     group=create(:group)
    #     get :show, params: { group_id: 1 }
    #     expect(assigns(:group)).to eq group
    #   end
      
    #   it "assigns the requested contact to @conne" do
    #   group=create(:group)
    #     get :show, params: { group_id: 1 }
    #     expect(assigns(:conne)).to eq group
    #   end
      
    #   it "assigns the requested contact to @events" do
    #   # events=create(:group)
    #   #   get :show, params: { group_id: 1 }
    #   #   expect(assigns(:conne)).to eq group
    #   end
      
    #   it "renders the :show template" do
    #     # 擬似的にnewアクションを動かすリクエストを行うコード
    #     get :show, params: { group_id: 1 }
    #     # 擬似的にshowアクションのリクエストをしたい場合
    #     # get :show, params: { id: 1 }
    #     # new.html.erbに遷移することを確かめるコード
    #     expect(response).to render_template :show
    #   end
    # end
    
    # describe 'GET #edit' do
    #   # インスタンス変数の値を確かめる
    #   it "assigns the requested contact to @conne" do
    #     group=create(:group)
    #     get :edit, params: {id: group}
    #     expect(assigns(:conne)).to eq group
    #   end
      
    #   it "assigns the requested contact to @group" do
    #     group=create(:group)
    #     get :edit, params: {id: group}
    #     expect(assigns(:group)).to eq group
    #   end
  
    #   it "renders the :edit template" do
    #     group=create(group)
    #     get :edit, params: {id: group}
    #     # new.html.erbに遷移することを確かめるコード
    #     expect(response).to render_template :edit
    #   end
    # end
    
    # describe 'GET #search' do
    #   it "" do
        
    #   end
  
  #     it "renders the :search template" do
  #       get :search
  #       expect(response).to render_template :search
  #     end
  # end
  
end
