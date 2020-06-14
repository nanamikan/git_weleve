class AppliesController < ApplicationController
  def new
      @event = Event.find(params[:event_id])
  end
  
  def create 
    @event = Event.find(params[:event_id])
    Apply.create(student_id: current_student.id, event_id: @event.id)
  end
  
  def edit 
  end
  
  def delete_confirm
    @apply = Apply.find(params[:id])
    @event = Event.find(params[:event_id])
  end
  
  def destroy
    @apply = Apply.find(params[:id])
    @event = Event.find(params[:event_id])
    
     if @apply.student_id ==current_student.id
        @apply.destroy 
     end
     redirect_to controller: 'events', action: 'index'
  end
  
  
  private
  def params_permit
    # params.require(:モデル名).permit(:カラム名)
    # permit(:student_id,:event_id)はユーザーに入力してもらうことではないので放置ｓ
    # params.require(:apply)
  end
end
