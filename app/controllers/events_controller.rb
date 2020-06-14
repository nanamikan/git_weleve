class EventsController < ApplicationController
  
  before_action :move_to_top, only: [:update, :edit, :destroy,:new,:create]
  
  def index
    @events = Event.includes(:group).all.order("date DESC").page(params[:page]).per(4)
    @apply = StudentEvent.find_by(student_id: current_student.id)
  end
  
  def new
    @group = Group.find(params[:group_id])
    @event = Event.new
  end 
  
  def create
    group = Group.find(params[:group_id])
    Event.create(title: params_permit[:title], date: params_permit[:date], where: params_permit[:where], descrip: params_permit[:descrip], image:  params_permit[:image],group_id: group.id )
    flash.notice = "イベントを追加しました"
    redirect_to controller: 'groups', action: 'show', id: group.id
  end
  
  def edit
    @event =Event.find(params[:id])
    @group = Group.find(params[:group_id])
  end
  
  def update
    group = Group.find(params[:group_id])
    event = Event.find(params[:id])
    event.update(params_permit)
    flash.notice = "イベントを更新しました"
    redirect_to controller: 'groups', action: 'show', id: group.id
  end
  
  def destroy
    @group = Group.find(params[:group_id])
    event = Event.find(params[:id])
      event.destroy!
    flash.notice = "イベントを削除しました"
    redirect_to controller: 'groups', action: 'show', id: @group.id
  end

  def show
    group = Group.find(params[:group_id])
    redirect_to controller: 'groups', action: 'show', id: group.id
  end
  
  def form
  end
  
  def search
    @events = Event.where(['title LIKE (?)', "%#{params[:e_keyword]}%"]).page(params[:page])
    @e_keyword = "#{params[:e_keyword]}"
  end
  
  private
    def params_permit
      params.require(:event).permit(:title,:date,:descrip,:where,:image)
    end
    
    def move_to_top
      group = Group.find(params[:group_id])
      unless current_student.group_authorized(group)
        flash.alert = "権限がありません"
        redirect_to root_path and return
      end
    end
  
end
