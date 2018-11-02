module ApplicationHelper
  def format_datetime(datetime)
    if datetime.strftime('%Y') != DateTime.now.strftime('%Y')
      datetime.strftime("%a %b %e, %Y, %H:%M %p (%z)")
    else
      datetime.strftime("%a %b %e, %H:%M %p (%z)")
    end
  end
end
