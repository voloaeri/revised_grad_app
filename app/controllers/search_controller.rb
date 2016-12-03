class SearchController < ApplicationController

  def searchStudents
    @PIDerror = false
    @searchResults = nil
    puts !params[:PID].nil? && !params[:lastName].nil?
    respond_to do |format|
      if !params[:PID].nil? && !params[:lastName].nil?
        if params[:PID].length != 9 && params[:lastName].nil?
          @PIDerror = true
          puts "DFDSF"
          format.js {}
          return
        end
        @searchResults = Student.where({PID: params[:PID].strip})
        if @searchResults.size == 0
          @searchResults = Student.where({lastName: params[:lastName].strip })
        end
        format.js {}
        return

    end
  end
  end
end
