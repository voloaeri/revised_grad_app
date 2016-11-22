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

  # GET /students/1
  # GET /students/1.json
  def show
    @doc_titles = Document.where({:student_id => params[:id]}).pluck(:title)
    @student = Student.find(params[:id])
    @job = Job.new(student: @student)
    @document = Document.new(student: @student)
    @course_description.student = @student.id
    @course_histories = CourseHistory.where(student_id: @student.id)
    @total_hours=0
    @comp_hours=0
    @theory=false
    @theory_course=0
    @systems=false
    @systems_course=0
    @applications=false
    @applications_course=0
    @ntwo_taken=false
    @nthree_taken=false
    @nfour_taken=false
    @nfour_hours=0
    @ptheory_counter=0
    @papps_counter=0
    @psystems_counter=0
    @pApplications=false
    @pTheory=false
    @pSystems=false
    @appCourses=""
    @systemCourses=""
    @theoryCourses=""
    @prp= @student.PRP
    @oralExam=@student.oralExam

    @committee= @student.committeeMeeting
    @abd= @student.ABD
    @diss= @student.dissertation_defense
    @final= @student.finalDiss
    @phdDate= @student.phdAdmitDate
    @student.course_histories.all.each do |course|
      @current_course=course.course_description
      hours= @current_course.hours.to_i
      name=@current_course.number.to_s

      if(@current_course.number==994)
        @nfour_hours=@nfour_hours+hours
      end
      if (@nfour_hours>=6)
        @nfour_taken=true
      end
      if (@current_course.department=="COMP" && @current_course.number!=990 && @current_course.number!=991)
        @comp_hours= @comp_hours+ hours
      end
      if (@current_course.number==992)
        @ntwo_taken=true
      end
      if (@current_course.number==993)
        @nthree_taken=true

      end
      if (@current_course.category=="Applications")
        @applications=true
        @papps_counter=@papps_counter+1
        @appCourses=@appCourses+name+", "
        if (@papps_counter>=2)
          @pApplications=true
        end
        if (@current_course.number>@applications_course)
          @applications_course=@current_course.number
        end
      end
      if (@current_course.category=="Theory")
        @theory=true
        @ptheory_counter=@ptheory_counter+1
        @theoryCourses=@theoryCourses+name+", "
        if (@ptheory_counter>=2)
          @pTheory=true
        end
        if (@current_course.number>@theory_course)
          @theory_course=@current_course.number
        end
      end
      if (@current_course.category=="Systems")
        @systems=true
        @psystems_counter=@psystems_counter+1
        @systemCourses=@systemCourses+name+", "
        if(@psystems_counter>=2)
          @pSystems=true
        end
        if (@current_course.number>@systems_course)
          @systems_course=@current_course.number
        end
      end

      @total_hours=@total_hours + hours
    end
    @applications_course= @applications_course.to_s
    @theory_course= @theory_course.to_s
    @systems_course= @systems_course.to_s
  end

  # GET /students/new
  def new
    #Defaults: Current Year and Semester and United States (Most students are probably USA citizens)
    year = Date.today.strftime("%Y");
    semester = getSemester(Date.today.strftime("%B"));
    @student = Student.new({:citizenship => "United States", :startedYear => year, :approvedYear => year, :startedSemester => semester, :approvedSemester => semester})
  end

  # GET /students/1/edit
  def edit
    @doc_titles = Document.where({:student_id => params[:id]}).pluck(:title)
    @student = Student.find(params[:id])

    @student.startedSemester = @student.semesterStartedCS.split(" ")[0]
    @student.startedYear = @student.semesterStartedCS.split(" ")[1]

    @student.approvedSemester = @student.backgroundApproved.split(" ")[0]
    @student.approvedYear = @student.backgroundApproved.split(" ")[1]

    @job = Job.new(student: @student)
    @document = Document.new(student: @student)
    @course_description = CourseDescription.new
    @course_description.student = @student.id
    @course_histories = CourseHistory.where(student_id: @student.id)

    @new_course_history = CourseHistory.new(student_id: @student.id)
    
    @total_hours=0
    @comp_hours=0
    @theory=false
    @theory_course=0
    @systems=false
    @systems_course=0
    @applications=false
    @applications_course=0
    @ntwo_taken=false
    @nthree_taken=false
    @nfour_taken=false
    @nfour_hours=0
    @ptheory_counter=0
    @papps_counter=0
    @psystems_counter=0
    @pApplications=false
    @pTheory=false
    @pSystems=false
    @appCourses=""
    @systemCourses=""
    @theoryCourses=""
    @prp= @student.PRP
    @oralExam=@student.oralExam

    @committee= @student.committeeMeeting
    @abd= @student.ABD
    @diss= @student.dissertation_defense
    @final= @student.finalDiss
    @phdDate= @student.phdAdmitDate

    @student.course_histories.all.each do |course|

      @current_course=course.course_description

      hours= @current_course.hours.to_i
      name=@current_course.number.to_s

      if(@current_course.number==994)
        @nfour_hours=@nfour_hours+hours
      end
      if (@nfour_hours>=6)
        @nfour_taken=true
      end
      if (@current_course.department=="COMP" && @current_course.number!=990 && @current_course.number!=991)
        @comp_hours= @comp_hours+ hours
        raise @comp_hours.inspect
      end
      if (@current_course.number==992)
        @ntwo_taken=true
      end
      if (@current_course.number==993)
        @nthree_taken=true

      end
      if (@current_course.category=="Applications")
        @applications=true
        @papps_counter=@papps_counter+1
        @appCourses=@appCourses+name+", "
        if (@papps_counter>=2)
          @pApplications=true
        end
        if (@current_course.number>@applications_course)
          @applications_course=@current_course.number
        end
      end
      if (@current_course.category=="Theory")
        @theory=true
        @ptheory_counter=@ptheory_counter+1
        @theoryCourses=@theoryCourses+name+", "
        if (@ptheory_counter>=2)
          @pTheory=true
        end
        if (@current_course.number>@theory_course)
          @theory_course=@current_course.number
        end
      end
      if (@current_course.category=="Systems")
        @systems=true
        @psystems_counter=@psystems_counter+1
        @systemCourses=@systemCourses+name+", "
        if(@psystems_counter>=2)
          @pSystems=true
        end
        if (@current_course.number>@systems_course)
          @systems_course=@current_course.number
        end
      end

      @total_hours=@total_hours + hours
     end
    @applications_course= @applications_course.to_s
    @theory_course= @theory_course.to_s
    @systems_course= @systems_course.to_s
    #raise @course_histories.inspect && @course_description.inspect
    #puts @course_description.student
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)
    @student.semesterStartedCS = student_params[:startedSemester] + " "  + student_params[:startedYear]
    @student.backgroundApproved = student_params[:approvedSemester] + " "  + student_params[:approvedYear]

    #raise @student.inspect
    @nameError = false
    @success = false
    @pidError = false

    respond_to do |format|

      if student_params[:firstName] == ""
        @nameError=true
        puts "name error"
        format.js { }
        return
      end

      if student_params[:lastName] == ""
        @nameError=true
        puts "name error"
        format.js { }
        return
      end

      if student_params[:PID] == ""
        @pidError=true
        puts "pid error"
        format.js { }
        return
      elsif !/\A\d+\z/.match(student_params[:PID])
        @pidError=true
        puts "pid error"
        format.js { }
        return
      elsif student_params[:PID].length!=9
        @pidError=true
        puts "pid error"
        format.js { }
        return
      end

      if @student.save
        @success = true
        format.js { redirect_to edit_student_url(@student), flash: { success: 'Student Created Successfully!' } }
        format.json { render :show, status: :created, location: @student }
      else
        format.js { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end

      end

  end


  def upload_photo

    @student = Student.find(student_params[:id])

    uploaded_io = student_params[:imageLocation]

    if (student_params[:imageLocation].tempfile.size.to_f / 1024000) > 1.5
      flash[:notice] = "Please upload an image less than 1.5 megabytes!"
      redirect_to edit_student_url(@student)
      return
    end

    imageTypes = {"image/png" => true, "image/jpeg" => true }

    if !imageTypes[uploaded_io.content_type]
      flash[:notice] = "Please upload a PNG or JPEG image"
      redirect_to edit_student_url(@student)
      return
    end


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
    @student.semesterStartedCS = student_params[:startedSemester] + " "  + student_params[:startedYear]
    @student.backgroundApproved = student_params[:approvedSemester] + " "  + student_params[:approvedYear]

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

  # GET /things/typeahead/:query
  def typeahead
    if params[:id] == "suggestions"  # Typeahead Prefetch default returns nothing. Prevents bug on page load.
      return
    end


    if search_params[:query].to_i.to_s == search_params[:query]
      puts "is true"
      @suggestions = Faculties.where('number LIKE ?', "%#{search_params[:query]}%").pluck(:lastName).map{ |s| {lastName: s[0]}}
      puts @suggestions
    else
      @suggestions = Faculties.where('name LIKE ?', "%#{search_params[:query]}%").pluck(:lastName).map{ |s| {lastName: s[0]}} #Select the data you want to load on the typeahead.
      puts @suggestions
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
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:firstName, :lastName, :PID, :alternativeName, :gender, :ethnicity, :status, :citizenship, :residency, :enteringStatus, :advisor, :researchArea, :startedYear, :approvedYear, :startedSemester, :approvedSemester, :backgroundApproved, :approvsemester,:approvyear,:leaveExtension, :fundingStatus, :fundingEligibility, :intendedDegree, :coursesTaken, :hoursCompleted, :imageLocation, :id,:PRP,:oralExam,:committeeMeeting,:ABD,:dissertation_defense,:finalDiss,:phdAdmitDate)
    end
end
