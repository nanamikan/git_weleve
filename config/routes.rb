Rails.application.routes.draw do
  devise_for :students
  root 'events#index'
  resources :students,only:[:show,:edit,:update] 
    resources :groups, only:[:show,:edit, :update] do
    # resources :applies, only:[:update,:edit,:create] do
    # 検索した値がパスに含まれるようなルーティングを生成
      collection do
        get 'search'
      end
      resources :events,except:[:index] 
  end
  
  resources :events,only:[:index] do
    resources :student_events, only:[:new,:create,:destroy, :index]
      collection do
        get 'search'
      end
  end
  
  get '/form'=>'events#form'
  get '/group/login'=>'groups#group_login'
  get '/group/logout'=>'groups#group_logout'
  get '/student_events/:id/events/:event_id/delete'=>'student_events#delete_confirm',as: :apply_delete
end
