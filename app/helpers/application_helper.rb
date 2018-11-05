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
    
    if !File.exist?(file_path) || File.size(file_path)
      unless File.exist?(path)
        FileUtils.mkdir_p(path)
      end

      open(file_path, 'wb') do |file|
        file << open("https://logo.clearbit.com/#{domain}").read
      end
    end

    "/images/logos/#{domain}.png"
  end
end
