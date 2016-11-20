class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery with: :exception

  def getSemester(month)
    fall = "Fall"
    spring = "Spring"
    summer = "Summer"
    case month
      when "January"
        return spring
      when "February"
        return spring
      when "February"
        return spring
      when "March"
        return spring
      when "April"
        return spring
      when "May"
        return summer
      when "June"
        return summer
      when "July"
        return summer
      when "August"
        return fall
      when "September"
        return fall
      when "October"
        return fall
      when "November"
        return fall
      when "December"
        return fall
    end
  end
  
end
