class FacultiesController < ApplicationController
  before_action :set_faculty, only: [:show, :edit, :update, :destroy]

  # GET /faculties
  def index
    allow_admin
    @faculties = Faculty.all
  end

  # GET /faculties/1
  def show
  end

  # GET /faculties/new
  def new
    allow_admin
    @faculty = Faculty.new
  end

  # GET /faculties/1/edit
  def edit
    allow_admin

  end

  # POST /faculties
  # Creating a new faculty member. Admin only. 
  def create

    allow_admin

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
  def update

    allow_admin

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
  def destroy

    allow_admin

    @faculty.destroy
    respond_to do |format|
      format.html { redirect_to faculties_url, notice: 'Faculty was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /things/typeahead/:query
  def typeahead

    allow_admin

    @suggestions = Faculty.where('lastName LIKE ?', "%#{search_params[:query]}%").pluck(:lastName, :firstName).map { |s| s[0] + ", " + s[1] } #Select the data you want to load on the typeahead.
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
