class EventsController < ApplicationController
  # テストのためいったんコメントアウト
  before_action :move_to_top, only: [ :update, :edit, :destroy]
  before_action :move_to_top_new, only: [:new,:create]
  
  def index
    @events=Event.includes(:group).all.order("date DESC").page(params[:page]).per(4)
    # @events=Event.includes(:groups).all.order("created_at DESC").page(params[:page]).per(3)
    @apply=Apply.find_by(student_id: current_student.id)
  end
  
  def new
    @group=Group.find(params[:group_id])
    @event=Event.new
  end
  
  def create
    @group=Group.find(params[:group_id])
    Event.create(title: params_permit[:title], date: params_permit[:date], where: params_permit[:where], descrip: params_permit[:descrip], image:  params_permit[:image],group_id: @group.id )
    flash.notice="イベントを追加しました"
    redirect_to controller: 'groups', action: 'show',id: @group.id
  end
  
  def edit
    @event=Event.find(params[:id])
    @group=Group.find(params[:group_id])
  end
  
  def update
    event=Event.find(params[:id])
    event.update(params_permit)
    flash.notice="イベントを更新しました"
    redirect_to root_path
  end
  
  def destroy
    @group=Group.find(params[:group_id])
    event=Event.find(params[:id])
      event.destroy!
    flash.notice="イベントを削除しました"
    redirect_to controller: 'groups', action: 'show', id: @group.id
  end

  def show
    group=Group.find(params[:group_id])
    redirect_to controller: 'groups', action: 'show', id: group.id
  end
  
  def form
  end
  
  def search
    @events=Event.where(['title LIKE (?)', "%#{params[:e_keyword]}%"]).page(params[:page])
    @e_keyword="#{params[:e_keyword]}"
  end
  
  private
    def params_permit
      # form_tagを利用しているので.requireは必要ない
      params.require(:event).permit(:title,:date,:descrip,:where,:image)
    end
    
    def move_to_top
      event=Event.find(params[:id])
      unless event.authorized?(current_student)
        flash.alert="権限がありません"
        redirect_to root_path
      end
    end
    
    # グループとしてログイン済みのユーザーが他のグループのeventを操作
    # しようとしてもリダイレクトされる
    def move_to_top_new
      # newとcreateアクションが動く時event変数はまだ定義されてない
      group=Group.find(params[:group_id])
      unless group.authorized?(current_student)
        redirect_to root_path
      end
    end
end
