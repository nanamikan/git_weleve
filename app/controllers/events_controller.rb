class EventsController < ApplicationController
  
  def index
    @events=Event.includes(:group).all.order("date DESC").page(params[:page]).per(4)
    # @events=Event.includes(:groups).all.order("created_at DESC").page(params[:page]).per(3)
    # binding.pry
    @apply=Apply.where(student_id: current_student.id).first
    # whereだけだと配列のようなものなのでfirstとすることでインスタンスとして取得可能になる
  end
  
  def new
    @group=Group.find(params[:group_id])
    @event=Event.new
  end
  
  def create
    @group=Group.find(params[:group_id])
    if current_student.groups.present? 
      if current_student.groups.first.id==@group.id 
        if current_student.connections.first.authority 
          Event.create(title: params_permit[:title], date: params_permit[:date], where: params_permit[:where], descrip: params_permit[:descrip], image:  params_permit[:image],group_id: @group.id ) 
        end
      end
    end
     redirect_to controller: 'groups', action: 'show',id: @group.id
  end
  
  def edit
     @event=Event.find(params[:id])
     @group=Group.find(params[:group_id])
    unless @event.group_id==@group.id
       redirect_to controller: 'groups', action: 'show', id: @group.id
    end
  end
  
 
  
  def form
  
  end
  
  def search
    @events=Event.where(['title LIKE (?)', "%#{params[:e_keyword]}%"]).page(params[:page])
    @e_keyword="#{params[:e_keyword]}"
    # binding.pry
  end
  
  def update
    @group=Group.find(params[:group_id])
    event=Event.find(params[:id])
     if event.group_id==@group.id
      event.update(params_permit)
      redirect_to controller: 'events', action: 'index'
     end
  end
  
  def destroy
    group=Group.find(params[:group_id])
    event=Event.find(params[:id])
    if current_student.groups.present? 
      if current_student.groups.first.id==group.id 
        if current_student.connections.first.authority 
          event.destroy
        end
      end
    end
    redirect_to controller: 'groups', action: 'show', id: group.id
  end
  
  private
    def params_permit
      # form_tagを利用しているので.requireは必要ない
      # binding.pry
      params.require(:event).permit(:title,:date,:descrip,:where,:image)
    end
end
