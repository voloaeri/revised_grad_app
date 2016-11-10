class CourseDescriptionsController < ApplicationController
  before_action :set_course_description, only: [:show, :edit, :update, :destroy]

  # GET /course_descriptions
  # GET /course_descriptions.json
  def index
    @course_descriptions = CourseDescription.all
  end

  def search
    puts "in Search!"

    @student = Student.find(params[:course_description][:student]);

    param_hash = {}
    param_hash[:number] = params[:course_description][:number] if params[:course_description][:number].present?
    param_hash[:name] = params[:course_description][:name] if params[:course_description][:name].present?
    param_hash[:category] = params[:course_description][:category] if params[:course_description][:category].present?
    param_hash[:hours] = params[:course_description][:hours] if params[:course_description][:hours].present?
    #param_hash = param_hash.to_query

    puts param_hash.inspect

    @results = CourseDescription.where(param_hash);

    puts @results.size
    

     @results.all.each do |c|
       puts c.number
     end

    respond_to do |format|
      format.js {}
      format.html {}
    end
    #render layout: false
  end

  # GET /course_descriptions/1
  # GET /course_descriptions/1.json
  def show
  end

  # GET /course_descriptions/new
  def new
    @course_description = CourseDescription.new
  end

  # GET /course_descriptions/1/edit
  def edit
  end

  # POST /course_descriptions
  # POST /course_descriptions.json
  def create

    @course_description = CourseDescription.new(course_description_params)

    respond_to do |format|
      if @course_description.save
        format.html { redirect_to @course_description, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course_description }
      else
        format.html { render :new }
        format.json { render json: @course_description.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /course_descriptions/1
  # PATCH/PUT /course_descriptions/1.json
  def update
    respond_to do |format|
      if @course_description.update(course_description_params)
        format.html { redirect_to @course_description, notice: 'Course description was successfully updated.' }
        format.json { render :show, status: :ok, location: @course_description }
      else
        format.html { render :edit }
        format.json { render json: @course_description.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /course_descriptions/1
  # DELETE /course_descriptions/1.json
  def destroy
    @course_description.destroy
    respond_to do |format|
      format.html { redirect_to course_descriptions_url, notice: 'Course description was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /things/typeahead/:query
  def typeahead
    puts "hello type"
    render json: @search.results
  end

  private

    def search_params
      params[:thing_search] || {}
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_course_description
      @course_description = CourseDescription.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_description_params
      params.require(:course_description).permit(:number, :name, :category, :hours)
    end
end
