module Settings
  class DoubleInitializeError < StandardError; end
end

class << Settings
  def init!
    raise Settings::DoubleInitializeError.new(
      'Settings had already been initialized') if @settings

    @settings = YAML.load(
      File.read(
        Rails.root.join('config', 'settings.yml')
      )
    )['settings']

    @settings['signup'] = true
  end

  def method_missing(method, *args, &block)
    method_s = method.to_s

    if method_s.match(/\?$/)
      # Switch
      !!@settings['switch'][method_s.gsub(/\?$/, '')]
    elsif @settings[method_s]
      # Normal Attribute
      @settings[method_s]
    else
      # No Match
      raise NoMethodError.new("undefined method `#{method}' for Settings")
    end
  end

  def raw
    @settings
  end
end

Settings.init!
