class EventsController < ApplicationController
  # テストのためいったんコメントアウト
  before_action :move_to_index, only: [ :update, :edit, :destroy]
  before_action :move_to_index_new, only: [:new,:create]
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
  end
  
  def create
    @group=Group.find(params[:group_id])
    Event.create(title: params_permit[:title], date: params_permit[:date], where: params_permit[:where], descrip: params_permit[:descrip], image:  params_permit[:image],group_id: @group.id )
    redirect_to controller: 'groups', action: 'show',id: @group.id
  end
  
  def edit
    @event=Event.find(params[:id])
    @group=Group.find(params[:group_id])
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
    event.update(params_permit)
    redirect_to root_path
  end
  
  def destroy
    @group=Group.find(params[:group_id])
    event=Event.find(params[:id])
      # if  event.group_id==@group.id
      event.destroy
      # end
    redirect_to controller: 'groups', action: 'show', id: @group.id
  end
  
  private
    def params_permit
      # form_tagを利用しているので.requireは必要ない
      # binding.pry
      params.require(:event).permit(:title,:date,:descrip,:where,:image)
    end
    
    def move_to_index
      group=Group.find(params[:group_id])
      event=Event.find(params[:id])
      if  current_student.groups.present?
          if current_student.groups.first.id==group.id&&current_student.connections.first.authority
            unless  event.group_id==group.id
               redirect_to root_path
            end
          else
            redirect_to root_path
          end
      else
        redirect_to root_path
      end
  
    end
    
    def move_to_index_new
      # newアクションが動く時event変数はまだ定義されてない
      group=Group.find(params[:group_id])
      if  current_student.groups.present?
          if current_student.groups.first.id==group.id&&current_student.connections.first.authority
           
          else
            redirect_to root_path
          end
      else
        redirect_to root_path
      end
    end
    
  
end
