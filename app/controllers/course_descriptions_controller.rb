class CourseDescriptionsController < ApplicationController
  before_action :set_course_description, only: [:show, :edit, :update, :destroy]

  # GET /course_descriptions
  # GET /course_descriptions.json
  def index

    allow_admin

    @course_descriptions = CourseDescription.all
  end

  def search

    allow_admin

    @semesterError = false
    @courseError = false

    respond_to do |format|

    @student = Student.find(params[:course_description][:student])

    #diane's way


    @course = CourseDescription.where({number: params[:course_description][:number]}).first
    

    if !@course
      @courseError = true
      puts "Course ERRROR"
      format.js {}
      return
    end

    #raise @course.inspect

    @semester = Semester.where(course_description_params.slice(:semester, :year).merge({course_description_id: @course.id})).first
   

    #raise @semester.inspect
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

      format.js {}
      format.html {}
    end
    #render layout: false
  end

  # GET /course_descriptions/1
  # GET /course_descriptions/1.json
  def show
    allow_admin

  end


  # GET /course_descriptions/new
  def new
    allow_admin

    @course_description = CourseDescription.new

  end

  # GET /course_descriptions/1/edit
  def edit
    allow_admin

  end

  # POST /course_descriptions
  # POST /course_descriptions.json
  def create
    allow_admin

    #raise course_description_params.except(:teacher, :year, :semester).inspect

    respond_to do |format|

      @facultyError = false
      @numberError = false
      @nameError = false
      @success=false

      if(course_description_params[:name] == "")
        @nameError = true
        format.js {}
        return
      end

      if(course_description_params[:number] == "")
        @numberError = true
        format.js {}
        return
      end

    @course_description = CourseDescription.find_or_create_by(course_description_params.except(:teacher, :year, :semester))

    name = course_description_params[:teacher].split(", ")

    faculty = Faculty.where({firstName: name[1], lastName: name[0]}).pluck(:id).first

    if(!faculty)
      @facultyError = true
      format.js {}
      return
    end




    #raise course_description_params.slice(:year, :semester).merge({faculty_id: faculty, course_description_id: @course_description.id}).inspect

    @semester = Semester.new(course_description_params.slice(:year, :semester).merge({faculty_id: faculty, course_description_id: @course_description.id}))

    @semester.save()
    
    #raise @semester.inspect

      if @course_description.save
        @success=true
        format.js { }


      else
        format.html { render :new }
        format.json { render json: @course_description.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /course_descriptions/1
  # PATCH/PUT /course_descriptions/1.json
  def update
    allow_admin
    respond_to do |format|
      # if @course_description.update(course_description_params)
        format.html { redirect_to @course_description, notice: 'Course description was successfully updated.' }
        format.json { render :show, status: :ok, location: @course_description }
      # else
      #   format.html { render :edit }
      #   format.json { render json: @course_description.errors, status: :unprocessable_entity }
      # end
    end
  end

  # DELETE /course_descriptions/1
  # DELETE /course_descriptions/1.json
  def destroy
    allow_admin
    @course_description.destroy
    respond_to do |format|
      format.html { redirect_to course_descriptions_url, notice: 'Course description was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /things/typeahead/:query
  def typeahead

    allow_admin

    if search_params[:query].to_i.to_s == search_params[:query]
      puts "is number"
      @suggestions = CourseDescription.where('number LIKE ?', "%#{search_params[:query]}%").pluck(:name,:number).map{ |s| {course: s[1].to_s + ": "  + s[0].to_s}}
      #raise @suggestions.to_json.inspect
    else
      puts "is name"
      @suggestions = CourseDescription.where('name LIKE ?', "%#{search_params[:query]}%").pluck(:name,:number).map{ |s| {name: s[0], number: s[1]}} #Select the data you want to load on the typeahead.
      #puts @suggestions
    end

    #@suggestions.values.join(" ")

    respond_to do |format|
      format.json { render json: @suggestions.to_json }
    end
  end

  private

    def search_params
      params.permit(:query) || {}
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_course_description
      @course_description = CourseDescription.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_description_params
      params.require(:course_description).permit(:number, :name, :category, :hours, :teacher, :semester, :year,:transfer,:department)
    end
end
