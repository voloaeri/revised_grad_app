class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]

  # GET /jobs
  # GET /jobs.json
  def index
    @jobs = Job.all
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
  end

  # GET /jobs/new
  def new
    @job = Job.new
  end

  # GET /jobs/1/edit
  def edit
    puts "in Edit"
    @job = Job.find(params[:id])
  end

  # POST /jobs
  # POST /jobs.json
  def create
    #raise params.inspect
    job_params.permit(:student_id,:position,:supervisor,:sem,:year,:course)
    @posError=false;
    @semError=false;
    @superError=false;
    @courseError=false;
    @ok=false


    respond_to do |format|
      @job = Job.new(job_params)
      @position= job_params[:position]
      @semester= job_params[:sem]+job_params[:year]
      @supervisor= job_params[:supervisor]
      @course = job_params[:course]
      @job.position=job_params[:sem]+job_params[:year]
      raise @job.inspect


      if job_params[:position] == ""
        @posError=true
        format.js { }
        return
      end

      if job_params[:semester] == ""
        @semError=true
        format.js { }
        return
      end

      if job_params[:supervisor] == ""
        @superError=true
        format.js { }
        return

      end

      if job_params[:course] == ""
        @courseError=true
        format.js { }
        return

      end

      if @job.save
        @ok=true
        @id= @job.id

        format.html { redirect_to edit_student_url(@job.student_id), notice: 'Job was successfully created.' }
        format.json { render :show, status: :created, location: @job }
        format.js {  }
      else
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to @job.student , notice: 'Job was successfully updated.' }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job.destroy

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.require(:job).permit(:position, :semester, :supervisor, :course, :student_id)
    end
end
