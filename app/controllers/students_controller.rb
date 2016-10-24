class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  def show_home
    render :layout => 'home'
  end

  # GET /students
  # GET /students.json
  def index
    @students = Student.all
  end

  def revised_edit
    @student = Student.find(params[:id])
    @job = Job.new(student: @student)
    @document = Document.new(student: @student)
    @course_description = CourseDescription.new
    @course_description.student = @student.id
    @course_histories = CourseHistory.where(student_id: @student.id)
  end

  # GET /students/1
  # GET /students/1.json
  def show
    @student = Student.find(params[:id])
    @job = Job.new(student: @student)
    @document = Document.new(student: @student)
    @course_description = CourseDescription.new
    @course_description.student = @student.id
    @course_histories = CourseHistory.where(student_id: @student.id)
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
    puts "in student edit"
    @student = Student.find(params[:id])
    @job = Job.new(student: @student)
    @document = Document.new(student: @student)
    @course_description = CourseDescription.new
    @course_description.student = @student.id
    @course_histories = CourseHistory.where(student_id: @student.id)
    #raise @course_histories.inspect && @course_description.inspect
    #puts @course_description.student
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to edit_student_url(@student), notice: 'Student was successfully created.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json

  def upload_photo

   # raise student_params.inspect

    uploaded_io = student_params[:imageLocation]
    @student = Student.find(student_params[:id])
    pid = @student.PID

    FileUtils.mkdir_p  Rails.public_path + "uploads/#{pid}"

    File.open(Rails.root.join('public', "uploads/#{pid}", uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end

    new_params = Hash.new
    new_params[:imageLocation] = "uploads/#{pid}/#{uploaded_io.original_filename}"
    new_params[:id] = student_params[:id];
    #raise new_params.inspect

    respond_to do |format|
      if @student.update(new_params)
        format.html { redirect_to edit_student_url(@student), notice: 'Student was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to edit_student_url(@student), notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: 'Student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:firstName, :lastName, :PID, :alternativeName, :gender, :ethnicity, :status, :citizenship, :residency, :enteringStatus, :advisor, :researchArea, :semesterStartedCS, :backgroundApproved, :leaveExtension, :fundingStatus, :fundingEligibility, :intendedDegree, :coursesTaken, :hoursCompleted, :imageLocation, :id)
    end
end