class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  def show_home
    render :layout => 'home'
  end


  # Home Search page
  def index

    if (!allow_faculty)
      return false
    end

    @students = Student.all
  end


  # Non Editable Student Page
  def show

    if (!allow_student params[:id])
      return false
    end

    @doc_titles = Document.where({:student_id => params[:id]}).pluck(:title)

    @student = Student.find(params[:id])
    @job = Job.new(student: @student)
    @document = Document.new(student: @student)
    @course_description = CourseDescription.new
    @course_description.student = @student.id

    # Calculations for the requirements page
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

      if (@current_course.number==994)
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
      if (@current_course.category=="Applications" && @current_course.department=="COMP")
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
      if (@current_course.category=="Theory" && @current_course.department=="COMP")
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
      if (@current_course.category=="Systems" && @current_course.department=="COMP")
        @systems=true
        @psystems_counter=@psystems_counter+1
        @systemCourses=@systemCourses+name+", "
        if (@psystems_counter>=2)
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


  # Creates the new student page
  def new

    if (!allow_admin)
      return false
    end

    #Defaults: Current Year and Semester and United States (Most students are probably USA citizens)
    year = Date.today.strftime("%Y");
    semester = getSemester(Date.today.strftime("%B"));
    @student = Student.new({:citizenship => "United States", :startedYear => year, :approvedYear => year, :startedSemester => semester, :approvedSemester => semester})
  end

  # Admin's edit Page
  def edit

    if (!allow_admin_faculty_no_edit params[:id])
      return false
    end

    # calculates requirements stuff It's repeated code. Sorry! You'll have to refactor it and place it in a helper module.
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

      if (@current_course.number==994)
        @nfour_hours=@nfour_hours+hours
      end
      if (@nfour_hours>=6)
        @nfour_taken=true
      end
      if (@current_course.department=="COMP" && @current_course.number!=990 && @current_course.number!=991)
        @comp_hours= @comp_hours+ hours
        #raise @comp_hours.inspect
      end
      if (@current_course.number==992)
        @ntwo_taken=true
      end
      if (@current_course.number==993)
        @nthree_taken=true

      end
      if (@current_course.category=="Applications" && @current_course.department=="COMP")
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
      if (@current_course.category=="Theory" && @current_course.department=="COMP")
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
      if (@current_course.category=="Systems" && @current_course.department=="COMP")
        @systems=true
        @psystems_counter=@psystems_counter+1
        @systemCourses=@systemCourses+name+", "
        if (@psystems_counter>=2)
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

  # called after submit is clicked on the new student page
  def create

    if (!allow_admin)
      return false
    end

    @student = Student.new(student_params)
    @student.firstName.capitalize!
    @student.lastName.capitalize!
    student_params[:PID].strip!
    @student.semesterStartedCS = student_params[:startedSemester] + " " + student_params[:startedYear]
    @student.backgroundApproved = student_params[:approvedSemester] + " " + student_params[:approvedYear]

    #raise @student.inspect
    @nameError = false
    @success = false
    @pidError = false
    @pidDup = false

    respond_to do |format|

      if student_params[:firstName] == ""
        @nameError=true
        puts "name error"
        format.js {}
        return
      elsif !/^[a-zA-Z\-]+$/.match(student_params[:firstName])
        @nameError=true
        puts "name error"
        format.js {}
      end

      if student_params[:lastName] == ""
        @nameError=true
        puts "name error"
        format.js {}
        return
      end

      if student_params[:PID] == ""
        @pidError=true
        puts "pid error"
        format.js {}
        return
      elsif !/\A\d+\z/.match(student_params[:PID])
        @pidError=true
        puts "pid error"
        format.js {}
        return
      elsif student_params[:PID].length!=9
        @pidError=true
        puts "pid error"
        format.js {}
        return
      end

      if Student.find_by(PID: student_params[:PID])
        puts "DUPL"
        @pidDup = true
        format.js {}
        return
      end

      if @student.save
        @success = true
        format.js { redirect_to edit_student_url(@student), flash: {success: 'Student Created Successfully!'} }
        format.json { render :show, status: :created, location: @student }
      else
        format.js { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end

    end

  end



  def upload_photo
    @admin=false
    @nameError=false
    if (!allow_admin_and_student student_params[:id])
      return false
    end
    if (session[:admin]==true)
      @admin=true
    end
    @student = Student.find(student_params[:id])




    uploaded_io = student_params[:imageLocation]
    if uploaded_io.nil?
      flash[:notice] = "Please select a picture to upload"
      if(@admin)
        redirect_to edit_student_url(@student)
      else
        redirect_to student_url(@student)
      end
      return
    end
    if (student_params[:imageLocation].tempfile.size.to_f / 1024000) > 1.5
      flash[:notice] = "Please select a smaller image"
      if(@admin)
        redirect_to edit_student_url(@student)
      else
        redirect_to student_url(@student)
      end
      return
    end

    imageTypes = {"image/png" => true, "image/jpeg" => true}

    if !imageTypes[uploaded_io.content_type]
      flash[:notice] = "Please upload a PNG or JPEG image"
      
      if(@admin)
        redirect_to edit_student_url(@student)
      else
        redirect_to student_url(@student)
      end
      return
    end


    pid = @student.PID

    FileUtils.mkdir_p Rails.public_path + "uploads/#{pid}"

    File.open(Rails.root.join('public', "uploads/#{pid}", uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end

    new_params = Hash.new
    new_params[:imageLocation] = "uploads/#{pid}/#{uploaded_io.original_filename}"
    new_params[:id] = student_params[:id]
    respond_to do |format|
      if @student.update(new_params)
        if (@admin==true)
          format.html { redirect_to edit_student_url(@student), notice: 'Student was successfully updated.' }
        else
          format.html { redirect_to student_url(@student), notice: 'Student was successfully updated.' }
        end
      else
        format.html { render :edit }
      end
    end
  end

  # Called when update is clicked on the edit page
  def update

    if (!allow_admin)
      return false
    end

    @nameError = false
    @success = false
    @pidError = false
    @pidDup = false
    @pidDup = false

    respond_to do |format|
      if student_params[:firstName] == ""
        @nameError=true
        puts "name error"
        format.js {}
        return
      elsif !/^[a-zA-Z\-]+$/.match(student_params[:firstName])
        @nameError=true
        puts "name error"
        format.js {}
      end

      if student_params[:lastName] == ""
        @nameError=true
        puts "name error"
        format.js {}
        return
      end

      if student_params[:PID] == ""
        @pidError=true
        puts "pid error"
        format.js {}
        return
      elsif !/\A\d+\z/.match(student_params[:PID])
        @pidError=true
        puts "pid error"
        format.js {}
        return
      elsif student_params[:PID].length!=9
        @pidError=true
        puts "pid error"
        format.js {}
        return
      end

      newPID_student = Student.find_by(PID: student_params[:PID])
      current_Student = Student.find(params[:id])

      # checks if pid is not used already and makes sure it isn't compared to itself.
      if !newPID_student.nil? && newPID_student.id != current_Student.id
        puts "DUPL"
        @pidDup = true
        format.js {}
        return
      end

      @student.semesterStartedCS = student_params[:startedSemester] + " " + student_params[:startedYear]
      @student.backgroundApproved = student_params[:approvedSemester] + " " + student_params[:approvedYear]

      if @student.update(student_params)
        @success = true
        format.html { redirect_to edit_student_url(@student), notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    if (!allow_admin)
      return false
    end

    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: 'Student was successfully destroyed.' }
      format.json { head :no_content }
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
    params.require(:student).permit(:firstName, :lastName, :PID, :alternativeName, :gender, :ethnicity, :status, :citizenship, :residency, :enteringStatus, :advisor, :researchArea, :startedYear, :approvedYear, :startedSemester, :approvedSemester, :backgroundApproved, :approvsemester, :approvyear, :leaveExtension, :fundingStatus, :fundingEligibility, :intendedDegree, :coursesTaken, :hoursCompleted, :imageLocation, :id, :PRP, :oralExam, :committeeMeeting, :ABD, :dissertation_defense, :finalDiss, :phdAdmitDate)
  end
end
