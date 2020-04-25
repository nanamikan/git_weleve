class StudentsController < ApplicationController
  
  def show
  # (1)自分のアカウントのプロフィールにアクセスした場合
  # (2)他人のアカウントのプロフィールにアクセスした場合
        @events=current_student.events.page(params[:page]).per(3).all.order("created_at DESC")
        # @events=Event.includes(:groups).all.order("created_at DESC").page(params[:page]).per(3)
        # @connection=Connection.where(student_id: current_student.id)
        @student=current_student
        @group=current_student.groups.first
        # redirect_to controller: 'events', action: 'index'
  end
  
  def edit
    @student=Student.find(params[:id])
     if  current_student.id==@student.id
        # @group=current_student.groups.first
     else
          redirect_to :show
     end
  end
  
  def authorize_update
    # @conneには一つのカラムのみが入ればよいので.whereではなく.find_by
    @conne=Connection.find_by(student_id: current_student.id)
    authorize(@conne)
    if @conne.authority==true
       redirect_to controller: 'groups', action: 'show', id: @conne.group_id
    else
       redirect_to controller: 'students', action: 'show', id: current_student.id
    end
  end
  def update
    @student=Student.find(params[:id])
    if @student.id==current_student.id
      # binding.pry
       logger.debug(update_params.inspect)
      if update_params[:avatar].present?
         current_student.avatar.attach(update_params[:avatar])
      end
      current_student.update(update_params)
    end
    redirect_to controller_path: 'show', id: @student.id
  end
  
  private
  # deviseを利用したモデルではemailとpasswordしか受け付けないように設定されている
  def update_params
    params.require(:student).permit(:name, :preference, :grade, :intro, :avatar)
  end
  
   def authorize(connection)
        @connection=connection
        # binding.pry
        # メソッドが呼びだされたらauthorityを現在の値とは逆の値にする
        @connection.authority=!(@connection.authority)
        @connection.save
   end
end
