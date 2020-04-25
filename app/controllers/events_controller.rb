class EventsController < ApplicationController
  # テストのためいったんコメントアウト
  before_action :move_to_index, only: [:new ,:create, :update, :edit, :destroy]
  def index
    @events=Event.includes(:group).all.order("date DESC").page(params[:page]).per(4)
    # @events=Event.includes(:groups).all.order("created_at DESC").page(params[:page]).per(3)
    # binding.pry
    @apply=Apply.where(student_id: current_student.id).first
    # whereだけだと配列のようなものなのでfirstとすることでインスタンスとして取得可能になる
  end
  
  def new
    # if current_student.groups.first.present?||
    @group=Group.find(params[:group_id])
    @event=Event.new
    
    if  current_student.groups.present?
      
        if current_student.groups.first.id==@group.id&&current_student.connections.first.authority
          
        else
          redirect_to root_path
        end
    else
      redirect_to root_path
    end
  end
  
  def create
    @group=Group.find(params[:group_id])
    if  current_student.groups.present?
        if  current_student.groups.first.id==@group.id&&current_student.connections.first.authority
          Event.create(title: params_permit[:title], date: params_permit[:date], where: params_permit[:where], descrip: params_permit[:descrip], image:  params_permit[:image],group_id: @group.id )
          redirect_to controller: 'groups', action: 'show',id: @group.id
        else
          redirect_to root_path
        end
    else
      redirect_to root_path
    end
    
  end
  
  def edit
    @event=Event.find(params[:id])
    @group=Group.find(params[:group_id])
   
    if  current_student.groups.present?
      # 両方trueなら何も起こらない(編集続行)
      if current_student.groups.first.id==@group.id&&current_student.connections.first.authority
        
      else
         redirect_to root_path
      end
    else
      redirect_to root_path
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
    event=Event.find(params[:id])
    @group=Group.find(params[:group_id])
    if  current_student.groups.present?
      # 両方trueならupdate
        if current_student.groups.first.id==@group.id&&current_student.connections.first.authority
          if event.group_id==@group.id
            event.update(params_permit)
          end
        end
    else
      # updateされようがされまいがredirect
    end
     redirect_to root_path
  end
  
  def destroy
    @group=Group.find(params[:group_id])
    event=Event.find(params[:id])
    
     if  current_student.groups.present?
        if current_student.groups.first.id==@group.id||current_student.connections.first.authority
         
        else
          
          if  event.group_id==@group.id
            event.destroy
          end
        end
    else
      redirect_to root_path
    end
    
    redirect_to controller: 'groups', action: 'show', id: group.id
  end
  
  private
    def params_permit
      # form_tagを利用しているので.requireは必要ない
      # binding.pry
      params.require(:event).permit(:title,:date,:descrip,:where,:image)
    end
    
    # def move_to_index
    #   @group=Group.find(params[:group_id])
    #   binding.pry
    #   if  current_student.groups.present?
        
    # 　else
    # 　  redirect_to root_path
    # 　end
    # end
    
  
end
