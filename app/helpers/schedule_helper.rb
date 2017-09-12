module ScheduleHelper

  def schedule_classes (is_current_user)
    classes = "btn btn-lg" 
    if is_current_user
      classes += " btn-info"
    else
      classes += " btn-danger"
    end
    return classes
  end
  
end
