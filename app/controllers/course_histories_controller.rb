class CourseHistoriesController < ApplicationController
  before_action :set_course_history, only: [:show, :edit, :update, :destroy]

  # GET /course_histories
  # GET /course_histories.json
  def index
    allow_admin

    @course_histories = CourseHistory.all
  end

  # GET /course_histories/1
  # GET /course_histories/1.json
  def show
    allow_admin
  end

  # GET /course_histories/new
  def new
    allow_admin
    @course_history = CourseHistory.new

  end

  # GET /course_histories/1/edit
  def edit
    allow_admin
    puts "in course histories edit"
    render false
  end

  # POST /course_histories
  # POST /course_histories.json
  # Used together with _form under course_histories under views to add a a course_desciption in a specific semester to a course_history. Admin only. Calls create.js.erb in views
  def create
    # puts "in Search!"
    #
    allow_admin
    @semesterError = false
    @courseError = false

    respond_to do |format|

      #raise params[:course_history][:student_id].inspect

      @student = Student.find(params[:course_history][:student_id])

      #diane's way


      @course = CourseDescription.where({number: params[:course_history][:number]}).first


      if !@course
        @courseError = true
        puts "Course ERRROR"
        format.js {}
        return
      end

      #raise @course.inspect

      @semester = Semester.where(course_history_params.slice(:semester, :year).merge({course_description_id: @course.id})).first



      if !@semester
        @semesterError = true
        puts "Semester ERROR"
        format.js {}
        return
      end

      @faculty = @semester.faculty

      @history = CourseHistory.new({course_description_id: @course.id, student_id: @student.id, semester_id: @semester.id})

      #raise @history.inspect

      @history.save()

      #raise @history.errors.inspect

      if(!@semesterError && !@courseError)
        flash[:success] = "Successful"
      else
        flash[:danger] = "fail. ;( "
      end

      format.js { redirect_to edit_student_url(@student) + "#history" }
      format.html {}
    end
    #render layout: false
  end

  # PATCH/PUT /course_histories/1
  # PATCH/PUT /course_histories/1.json
  def update
    allow_admin
    respond_to do |format|
      if @course_history.update(course_history_params)
        format.html { redirect_to @course_history, notice: 'Course history was successfully updated.' }
        format.json { render :show, status: :ok, location: @course_history }
      else
        format.html { render :edit }
        format.json { render json: @course_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /course_histories/1
  # DELETE /course_histories/1.json

  def search_and_destroy
    @course_history = CourseHistory.find(course_history_params[:id])
    destroy()
  end

  def destroy
    #raise @course_history.inspect
    allow_admin
    @course_history.destroy
    respond_to do |format|
      format.js {}
      #format.html { redirect_to edit_student_url(course_history_params[:student_id]), notice: 'Successfully unenrolled from Course' }
     # format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_history
      @course_history = CourseHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_history_params
      params.require(:course_history).permit(:id, :student_id, :course_description_id, :grade, :year, :semester, :section, :faculty_id, :semester,:number,:name)
    end
end
