require 'fileutils'

class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]

  # GET /documents
  # GET /documents.json
  def index
    @documents = Document.all
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    puts "in Document Edit"
  end

  # GET /documents/new
  def new
    @document = Document.new
  end

  # GET /documents/1/edit
  def edit
    puts "in Document Edit"
  end

  # POST /documents
  # POST /documents.json
  def create
    uploaded_io = params[:document][:location]
    studentName = Student.find(params[:document][:student_id]).lastName

    FileUtils.mkdir_p  Rails.public_path + "uploads/#{studentName}"

    File.open(Rails.root.join('public', "uploads/#{studentName}", uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end

    params[:document][:location] = "uploads/#{studentName}/#{uploaded_io.original_filename}"
    @document = Document.new(document_params)
    respond_to do |format|
      if @document.save
        format.html { redirect_to edit_student_url(@document.student_id), notice: 'Document was successfully uploaded.' }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    # uploaded_io = params[:document][:location]
    # folder = "public/uploads/#{@document.student.lastName}"
    # FileUtils.mkdir_p folder
    # File.open(Rails.root.join('public', "uploads/#{@document.student.lastName}", uploaded_io.original_filename), 'wb') do |file|
    #   file.write(uploaded_io.read)
    # end
    # params[:document][:location] = "uploads/#{@document.student.lastName}/#{uploaded_io.original_filename}"
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to @document, notice: 'Document was successfully uploaded.' }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to edit_student_url(@document.student_id), notice: 'Document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(:title, :location, :student_id)
    end
end
