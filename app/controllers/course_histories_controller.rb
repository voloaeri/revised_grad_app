class CourseHistoriesController < ApplicationController
  before_action :set_course_history, only: [:show, :edit, :update, :destroy]

  # GET /course_histories
  # GET /course_histories.json
  def index
    @course_histories = CourseHistory.all
  end

  # GET /course_histories/1
  # GET /course_histories/1.json
  def show
  end

  # GET /course_histories/new
  def new
    @course_history = CourseHistory.new

  end

  # GET /course_histories/1/edit
  def edit
    puts "in course histories edit"
    render false
  end

  # POST /course_histories
  # POST /course_histories.json
  def create

    respond_to do |format|
      @course_history = CourseHistory.new(course_history_params)

      flash[:notice] = "Cannot enroll twice"

      puts "Outside the IF ! "
      if CourseHistory.where(course_history_params).size > 0
        puts "Tried to enroll in same class twice!"
        #render inline: "location.reload();", :notice => "Can't enroll twice!"
        redirect_to edit_student_path(Student.find(course_history_params[:student_id]))
        #redirect_to proc {edit_student_path(course_history_params[:student_id])}
        return
      end

      if @course_history.save #saves the new course history of student
       # format.js { render edit_student_path(course_history_params[:student_id]), notice: 'Course history was successfully created.' }
        format.js {render inline: "location.reload();" } # reloads the page
         format.html { redirect_to "/students/#{course_history_params[:student_id]}/edit", notice: 'Course history was successfully created.' }
        # format.json { render :show, status: :created, location: @course_history }
        # format.js { redirect_to "/students/#{course_history_params[:student_id]}/edit", notice: 'Course history was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @course_history.errors, status: :unprocessable_entity }
      end
    end
     #render edit_student_path(course_history_params[:student_id])
  end

  # PATCH/PUT /course_histories/1
  # PATCH/PUT /course_histories/1.json
  def update
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
    @course_history.destroy
    respond_to do |format|
      format.html { redirect_to edit_student_url(course_history_params[:student_id]), notice: 'Successfully unenrolled from Course' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_history
      @course_history = CourseHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_history_params
      params.require(:course_history).permit(:id, :student_id, :course_description_id, :grade, :section, :faculty_id, :semester)
    end
end
