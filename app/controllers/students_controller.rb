class StudentsController < ApplicationController
  
  def show
    @student = Student.find(params[:id])
    @events = @student.events.page(params[:page]).per(3).all.order("created_at DESC")
    if @student == current_student
      if current_student.groups.present?
        @group = current_student.groups.first
      end
    end
  end
  
  def edit
    @student = Student.find(params[:id])
     unless  current_student.id == @student.id
       redirect_to :show
     end
  end
  
  def update
    @student = Student.find(params[:id])
    if @student.id == current_student.id
      if update_params[:avatar].present?
        current_student.avatar.attach(update_params[:avatar])
      end
      current_student.update(update_params)
    end
    redirect_to controller_path: 'show', id: @student.id
  end
  
 private
  def update_params
    params.require(:student).permit(:name, :preference, :grade, :intro, :avatar)
  end
end
