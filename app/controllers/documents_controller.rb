require 'fileutils'

class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]

  # POST /documents
  # POST /documents.json
  def create

    if(session[:admin] || session[:student_id].to_s == params[:document][:student_id].to_s)
      puts session[:admin]
      puts session[:faculty]
      puts session[:student_id]
    else
      raise "no access".inspect
    end

    @pdfError = false
    @selectError = false
    @warning = false;

    respond_to do |format|

      @document = Document.new(document_params)

      #raise @document.inspect

      uploaded_io = params[:document][:location]
      uploaded_io.original_filename = document_params[:title].to_s + ".pdf"

      studentName = Student.find(params[:document][:student_id]).lastName

      @document[:location] = "uploads/#{studentName}/#{uploaded_io.original_filename}"

      @dupQuery = Hash.new
      @dupQuery[:student_id] =  @document[:student_id]
      @dupQuery[:title] =  @document[:title]

      @results = Document.where(@dupQuery)
      if @results.size >= 1
        @warning = true;
        @subDoc = @results.first
        @dupQuery[:location] = "uploads/#{studentName}/#{uploaded_io.original_filename}"
        @uploaded_io = uploaded_io
        @studentName = studentName
        @dupQuery[:updated_at] = Time.now

        format.js { }
        return
      end

      if document_params[:title] == "Select One"
        @selectError = true
        format.js { }
        return
      end

      if uploaded_io.content_type != "application/pdf"
        @pdfError = true
        format.js { }
        return
      end

      #raise uploaded_io.original_filename.inspect

      FileUtils.mkdir_p  Rails.public_path + "uploads/#{studentName}"

      File.open(Rails.root.join('public', "uploads/#{studentName}", uploaded_io.original_filename), 'wb') do |file|
        file.write(uploaded_io.read)
      end

      params[:document][:location] = "uploads/#{studentName}/#{uploaded_io.original_filename}"




      if @document.save
        puts "Just saved"
        format.js { }
        format.html { raise "HTML... again" }
        #format.html { redirect_to edit_student_url(@document.student_id), :flash => {success: 'Document was successfully uploaded.'}}
      else
        # format.html { render :edit }
        # format.json { render json: @document.errors, status: :unprocessable_entity }
        format.js {}
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    if(session[:admin] || session[:student_id].to_s == params[:document][:student_id].to_s)
      puts session[:admin]
      puts session[:faculty]
      puts session[:student_id]
    else
      raise "no access".inspect
    end
    
    puts Rails.public_path + @document.location
    FileUtils.rm(Rails.public_path + @document.location)
    @document.destroy
    respond_to do |format|
      format.js {}
      # format.html { redirect_to edit_student_url(@document.student_id), notice: 'Document was successfully destroyed.' }
      # format.json { head :no_content }
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
