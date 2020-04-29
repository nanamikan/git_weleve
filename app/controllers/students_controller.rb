class StudentsController < ApplicationController
  
  def show
    @student=Student.find(params[:id])
    @events=@student.events.page(params[:page]).per(3).all.order("created_at DESC")
    if @student==current_student
        if current_student.groups.present?
            @group=current_student.groups.first
        end
    end
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
