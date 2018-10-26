ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  html_dom = Nokogiri::HTML(html_tag.to_s)
  input = html_dom.css('input').first
  input['class'] = (input['class'] || '') + ' field_with_errors'
  input.to_s.html_safe
end
