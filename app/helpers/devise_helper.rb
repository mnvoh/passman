module DeviseHelper
  def devise_error_messages!
    return "" unless devise_error_messages?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join

    error_count_msg = resource.errors.count > 1 ?
      "are #{resource.errors.count} errors" :
      "is one error"
    message_header = "There #{error_count_msg} in the form!"

    html = <<-HTML
    <div class="alert alert-danger text-left">
      <p>#{message_header}</p>
      <ul>#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end

  def devise_error_messages?
    !resource.errors.empty?
  end

end
