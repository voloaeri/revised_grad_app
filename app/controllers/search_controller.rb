class SearchController < ApplicationController
  # Search page for students. Only searches on either PID or last name, js file in applications clears one text box when the other is clicked. Calls searchStudents.js.erb
  # under search under views. Only 9 digit PIDS are allowed
  def searchStudents
    allow_faculty
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
