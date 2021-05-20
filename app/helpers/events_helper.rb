module EventsHelper

  def creator?(user, event)
    return true if event.organizer == user

    false
  end

  def on_the_list?(customer, event)
    invited = []
    event.attendances.each do |a|
      invited << a.user
    end
    return true if invited.include?(customer) 

    false
  end

end
