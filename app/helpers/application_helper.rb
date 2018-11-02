module ApplicationHelper
  def format_datetime(datetime)
    if datetime.nil?
      return
    end

    if datetime.strftime('%Y') != DateTime.now.strftime('%Y')
      datetime.strftime("%a %b %e, %Y, %H:%M %p %Z")
    else
      datetime.strftime("%a %b %e, %H:%M %p %Z")
    end
  end
end
