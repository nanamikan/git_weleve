Rails.application.routes.draw do
  devise_for :students
  
  root to: 'events#index'
   
  resources :students,only:[:show,:edit,:update] 
  # do
  # resources :applies, only:[:update,:edit,:create] do
  #   resources :events
  # end
 
 resources :groups, only:[:show,:edit, :update] do
  # resources :applies, only:[:update,:edit,:create] do
    resources :events,only:[:create,:new,:edit, :update,:destroy]
    collection do
      get 'search'
    end
  end
  resources :events do
    resources :applies, only:[:new,:create,:destroy]
     collection do
      get 'search'
    end
  end
  get '/form'=>'events#form'
  get '/authorize/update'=>'students#authorize_update'
  get '/applies/:id/events/:event_id/delete'=>'applies#delete_confirm'
  
end
