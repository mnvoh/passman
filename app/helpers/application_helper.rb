require 'open-uri'
require 'fileutils'

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

  def brand_logo(domain)
    if domain.nil? || !/^[a-z0-9-]+\.[a-z]+$/.match?(domain)
      return ActionController::Base.helpers.image_url('passman.svg')
    end

    path = Rails.root.join('public', 'images', 'logos')
    file_path = Rails.root.join(path, "#{domain}.png")
    
    if !File.exist?(file_path) || File.size(file_path) <= 0
      unless File.exist?(path)
        FileUtils.mkdir_p(path)
      end

      open(file_path, 'wb') do |file|
        file << open("https://logo.clearbit.com/#{domain}").read
      end
    end

    "/images/logos/#{domain}.png"
  end

  def five_star(value)
    title = I18n.t('password_strength') + ": #{value + 1}/5"
    five_star_html = '<span class="five-star float-right" title="' + title + '">'

    [0, 1, 2, 3, 4].each do |i|
      if i <= value
        five_star_html += '<i class="fas fa-star filled"></i>'
      else
        five_star_html += '<i class="fas fa-star hollow"></i>'
      end
    end

    five_star_html += '</span>'
    five_star_html.html_safe
  end
end
