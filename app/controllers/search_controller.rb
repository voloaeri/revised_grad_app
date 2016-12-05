class SearchController < ApplicationController

  def searchStudents
    @PIDerror = false
    @searchResults = nil
    puts !params[:PID].nil? && !params[:lastName].nil?
    respond_to do |format|

      if !params[:PID].nil? && !params[:lastName].nil?
        if params[:PID].length.to_i != 9 && params[:lastName]==""
          @PIDerror = true

          format.js {}

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
