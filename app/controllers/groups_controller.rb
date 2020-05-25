class GroupsController < ApplicationController
    require 'date'
#   before_action :move_to_top unless current_student.group
    
    def show 
      @conne=Connection.find_by(student_id: current_student.id)
      @group=Group.find(params[:id])
      @events=@group.events.order("created_at DESC").page(params[:page]).per(3)
      @today=Date.today
    end
    
    def search
      @groups=Group.where('name LIKE(?)', "%#{params[:g_keyword]}%" ).page(params[:page])
      @g_keyword="#{params[:g_keyword]}"
    end
    
    def edit
      @group=Group.find(params[:id])
      if @group.authorized?(current_student)
        @group=current_student.groups.first
        @grade=current_student.grade
      else
        redirect_to :group
      end
    end
    
    def update
    #   groupアカウントと紐づいている&&
    #   ログイン中の生徒のgroup==@group&&
    #   authority==true
    @group=Group.find(params[:id])
      if  @group.authorized?(current_student)
        current_student.groups.first.update(update_params)
        flash.notice="プロフィールを更新しました"
        redirect_to :group
      else
        redirect_to :group
      end
    end
    
  private
  
    def move_to_top
      redirect_to  controller: 'students', action: 'show'
    end
    
    def update_params
      params.require(:group).permit(:name,:category,:what_to_do,:intro,:image)
    end
    
end
