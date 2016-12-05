class FacultiesController < ApplicationController
  before_action :set_faculty, only: [:show, :edit, :update, :destroy]

  # GET /faculties
  # GET /faculties.json
  def index
    if(session[:admin])
      puts session[:admin]
      puts session[:faculty]
      puts session[:student_id]
    else
      raise "no access".inspect
    end

    @faculties = Faculty.all
  end

  # GET /faculties/1
  # GET /faculties/1.json
  def show
  end

  # GET /faculties/new
  def new
    @faculty = Faculty.new
  end

  # GET /faculties/1/edit
  def edit
  end

  # POST /faculties
  # POST /faculties.json
  def create

    if(session[:admin])
      puts session[:admin]
      puts session[:faculty]
      puts session[:student_id]
    else
      raise "no access".inspect
    end

    @faculty = Faculty.new(faculty_params)

    respond_to do |format|
      if @faculty.save
        format.html { redirect_to @faculty, notice: 'Faculty was successfully created.' }
        format.json { render :show, status: :created, location: @faculty }
      else
        format.html { render :new }
        format.json { render json: @faculty.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /faculties/1
  # PATCH/PUT /faculties/1.json
  def update

    if(session[:admin])
      puts session[:admin]
      puts session[:faculty]
      puts session[:student_id]
    else
      raise "no access".inspect
    end

    respond_to do |format|
      if @faculty.update(faculty_params)
        format.html { redirect_to @faculty, notice: 'Faculty was successfully updated.' }
        format.json { render :show, status: :ok, location: @faculty }
      else
        format.html { render :edit }
        format.json { render json: @faculty.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /faculties/1
  # DELETE /faculties/1.json
  def destroy

    if(session[:admin])
      puts session[:admin]
      puts session[:faculty]
      puts session[:student_id]
    else
      raise "no access".inspect
    end

    @faculty.destroy
    respond_to do |format|
      format.html { redirect_to faculties_url, notice: 'Faculty was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /things/typeahead/:query
  def typeahead

    if params[:id] == "suggestions"  # Typeahead Prefetch default returns nothing. Prevents bug on page load.
      return
    end
    #@suggestions = CourseDescription.where("name LIKE" => "%#{search_params[:query]}%")
    @suggestions = Faculty.where('lastName LIKE ?', "%#{search_params[:query]}%").pluck(:lastName, :firstName).map{ |s| s[0] + ", " + s[1] } #Select the data you want to load on the typeahead.
    #@suggestions.map{ |s| {name: s[0], number: s[1], hours: s[2]}}
    puts @suggestions
    respond_to do |format|
      format.json { render json: @suggestions.to_json }
    end
  end

  private
    def search_params
      params.permit(:query) || {}
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_faculty
      @faculty = Faculty.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def faculty_params
      params.require(:faculty).permit(:firstName, :lastName, :sectionNumber, :PID, :isAdmin)
    end
end
