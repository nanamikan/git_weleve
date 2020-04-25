require 'rails_helper'
  describe EventsController,type: :controller  do
  #   describe 'GET #new' do
      
  #     it "assigns the requested contact to @event" do
  #       event=create(:event)
  #       get :new, params: { group_id: 1 }
  #       expect(assigns(:event)).to eq event
  #     end
      
  #     it "assigns the requested contact to @group" do
  #       group=create(:group)
  #       get :new, params: { group_id: 1 }
  #       expect(assigns(:group)).to eq group
  #     end
      
  #     it "renders the :new template" do
  #       # 擬似的にnewアクションを動かすリクエストを行うコード
  #       get :new, params: { group_id: 1 }
  #       # 擬似的にshowアクションのリクエストをしたい場合
  #       # get :show, params: { id: 1 }
  #       # new.html.erbに遷移することを確かめるコード
  #       expect(response).to render_template :new
  #     end
  #   end
    
  #   describe 'GET #edit' do
  #     # インスタンス変数の値を確かめる
  #     it "assigns the requested contact to @event" do
  #       event=create(:event)
  #       get :edit, params: {id: event}
  #       expect(assigns(:event)).to eq event
  #     end
  
  #     it "renders the :edit template" do
  #       event=create(event)
  #       get :edit, params: {id: event}
  #       # new.html.erbに遷移することを確かめるコード
  #       expect(response).to render_template :edit
  #     end
  #   end
    
  #   describe 'GET #index' do
      
  #     # ログインしてたらevents#index見れるよお
  #     context 'as an authorized user' do
  #       it "populates an array of tweets ordered by created_at DESC" do
  #         events=create_list(:event, 3)
  #         get :index
  #         expect(assigns(:tweets)).to match(tweets.sort{ |a, b| b.created_at <=> a.created_at } )
  #       end
  
  #       it "renders the :index template" do
  #         get :index
  #         expect(response).to render_template :index
  #       end
        
  #     end
       
  #     # ログインしてなかったらリダイレクトするよお
  #       context "as a guest" do
  #         it "responses a 302 response" do
  #         end
        
  #         it "redirects to sign_in_page" do
  #         end
          
  #       end
      
  # end
  
  # event新規作成
  describe "GET#new"  do
    context "as an authenticated user"  do
      
      before do
        # groupと紐づいているxtudentならevent新規作成ページに行ける
        @student=create(:student,:with_group)
      end
      
      it "responds successfully" , retry: 3 do
        sign_in @student
        get :new
        aggregate_failures do
          expect(response).to be_success
          expect(response).to have_http_status "200"
        end
      end
      
    end
     # groupと紐づいていてないユーザーならば
    context "as an unauthorized user" do
      
      before do
        @student=create(:student)
      end
       
      it "responses a 302 response" do
        sign_in @student
        get :new
        expect(response).to have_http_status "302"
      end
        
      it "redirects to student's #show" do
        sign_in @student
        get :new
        expect(response).to redirect_to controller: 'students', action: 'show', id: @student.id
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
    
  end
    
  describe 'POST #create' do
    # groupと紐づいているユーザーかつ # eventのgroup_idがstudentのgroup_idならば
    context 'as an authorized user' do
        before do
          @student=create(:student,:with_group)
        end
        #有効な属性値の場合
        # eventのgroup_idがstudentのgroup_idならば
        context "with valid attributes" do
          it "adds an event"do
            event_params=attributes_for(:event, group_id: @student.groups.first.id)
            sign_in @student
            expect{
              post :create, params:{ event: event_params}
            }.to change(@student.groups.first.events, :count).by(1)
          end
        end
        
        #無効な属性値の場合
        context "with invalid attributes" do
          it "doesn't add an event" do
            event_params=attributes_for(:event, :invalid)
            sign_in @student
            expect{
              post :create, params:{ event: event_params}
            }.to not_change(@student.events, :count)
          end
        end
        
     end
     
      # groupと紐づいていてないユーザーならば
    context "as an unauthorized user" do
      
      before do
        @student=create(:student)
      end
       
      it "responses a 302 response" do
        sign_in @student
        get :new
        expect(response).to have_http_status "302"
      end
     
        
      it "redirects to student's #show" do
        sign_in @student
        get :new
        expect(response).to redirect_to controller: 'students', action: 'show', id: student.id
      end
      
    end
     #ログインしてないならば
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
   
   
   
  describe 'GET #edit' do
    # context 'as an authorized user' do
    context '@events group_id corresponds to @students group_id' do
      
      before do
        @student=create(:student,:with_group)
        @event=create(:event, group_id: @student.groups.first.id)
      end
        
      it "responds successfully" do
        sign_in @student
        get :new
        
        aggregate_failures do
          expect(response).to be_success
          expect(response).to have_http_status "200"
        end
      end
      
     end
      
    context "as unauthorized user" do
      before do
        @student=create(:student,:with_group)
        @unauthorized_student=create(:student)
        @event=create(:event, group_id: @student.groups.first.id)
      end
      
       it "redirects to student's #show" do
         sugn_in @unauthorized_student
         get :new
         expect(response).to redirect_to controller: 'students', action: 'show', id: @unauthorized_student.id
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
   
   
  describe 'PATCH #update' do
    context 'as an authorized user' do
      before do
        @student=create(:student,:with_group)
        # updateされる前のeventデータ
        event1h
        @event=create(:event, group_id: @student.groups.first.id)
      end
      
       #有効な属性値の場合
      context "with valid attributes" do
        it "updates an event"do
          event_params=attributes_for(:event, title: "update")
          sign_in @student
          post :update, params:{ event: event_params, group_id: @student.groups.first.id}
          expect (@student.groups.first.events.first.title).to eq "update"
        end
      end
      
      
      #無効な属性値の場合
      # @eventの値はevent_paramsに更新されない
      context "with invalid attributes" do
        it "doesn't update an event"do
          event_params=attributes_for(:event,:invalid)
          sign_in @student
          
          post :update, params:{ event: event_params}
          # @eventのdateは有効な値だが、event_paramsのdateは無効
          expect (@event.date).to not_eq event_params.date
        end
        
      end
      
    end
     
    context "as unauthorized user" do
      before do
        @student=create(:student,:with_group)
        # groupと紐づいてない
        @unauthorized_student=create(:student)
        @event=create(:event, group_id: @student.groups.first.id)
      end
      
      it "does not update an event"do
        event_params=attributes_for(:event,title:"update")
        sign_in @unauthorized_student
        post :update, params:{ event: event_params,group: @student.groups.first.id}
        expect(@event.title).to "hoge"
      end
       
      it "redirects to student's #show"do
       get :new
       expect(response).to redirect_to controller: 'students', action: 'show', id: @student.id
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
        @event=create(:event, group_id: @student.groups.first.id)
      end
      
      it "deletes an event" do
        sign_in @student
        expect{
          delete :destroy, params:{ id: @event.id}
        }.to change(@student.groups.first.events, :count).by(-1)
      end
      
     end
     
    context "as unauthorized user" do
      
      before do
        @student=create(:student,:with_group)
        @unauthorized_student=create(:student)
        @event=create(:event, group_id: @student.groups.first.id)
      end
       
      it "does not delete an event"do
        sign_in @unauthorized_student
        expect{
          delete :destroy, params:{ id: @event.id}
        }.to not_change(@student.groups.first.events, :count)
      end
      
      it "redirects to student's #show"do
        get :new
       expect(response).to redirect_to controller: 'students', action: 'show', id: @unauthorized_student.id
      end
       
     end
     
    context "as a guest" do
      before do
        @event=create(:event, group_id: @student.groups.first.id)
      end
      
      it "responses a 302 response" do
        get :new
        expect(response).to have_http_status "302"
      end
        
      it "redirects to sign_in_page" do
        get :new
        expect(response).to redirect_to "/students/sign_in"
      end
      
      it "can not delete an event"do
        expect{
          delete :destroy, params:{ id: @event.id}
        }.to not_change(@student.groups.first.events, :count)
      end
       
    end
     
 
  end
  
end


