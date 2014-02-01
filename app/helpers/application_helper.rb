require 'yaml'
require 'fileutils'

module ApplicationHelper
  # Initialized Config:Settings
  Settings = YAML.load(File.read(Rails.root.join('config', 'settings.yml')))['settings']

  def humanized_version
    frozen_proton_version = Settings['app_version'] rescue nil
    frozen_proton_version ? "#{frozen_proton_version}" : '1.0.0'
  end

  def page_title    
    path   = request.parameters['controller'].gsub(/\//, '.')
    action = request.parameters['action']
    return Settings['app_name'] if request.path == '/'
    %Q[#{Settings['app_name']} :: #{I18n.t(%Q<titles.#{path}.#{action}>)}]
  end
  
  def errors_for(object, message=nil)
    html = ""
    unless object.errors.blank?
      html << "<div class='formErrors #{object.class.name.humanize.downcase}Errors'>\n"
      if message.blank?
        if object.new_record?
          html << "\t\t<h4>There was a problem creating the #{object.class.name.humanize.downcase}:</h4>\n"
        else
          html << "\t\t<h4>There was a problem updating the #{object.class.name.humanize.downcase}:</h4>\n"
        end    
      else
        html << "<h5>#{message}</h5>"
      end  
      html << "\t\t<ul>\n"
      object.errors.full_messages.each do |error|
        html << "\t\t\t<li>#{error}</li>\n"
      end
      html << "\t\t</ul>\n"
      html << "\t</div>\n"
    end
    html.html_safe
  end
  
end
