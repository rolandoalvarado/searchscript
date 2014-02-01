require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module FrozenProton
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths += %W(#{config.root}/lib/autoloadables)  
  
    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    
    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path += Dir.glob(Rails.root.join('config', 'locales', '**', '*.yml'))
    config.i18n.default_locale = :en

    config.i18n.available_locales = [:en]
    config.i18n.fallbacks = [:en]
    
    config.assets.enabled = true
    #config.assets.version = ::Version.to_s
    #config.assets.precompile.push /^(i18n)\/.*(js|css|scss)$/
    
    # -------------------------------------------------------------------------
    # Use this config in testing email via localhost.
    config.action_mailer.delivery_method = :sendmail #:smtp
    config.action_mailer.perform_deliveries = true
    config.action_mailer.raise_delivery_errors = true
    #config.action_mailer.default_url_options = { :host => 'localhost:3000' } # For Local Host
    config.action_mailer.default_url_options = { :host => 'dev002.teknofx.com' } # For Staging
    # -------------------------------------------------------------------------
    config.active_record.observers = :user_observer
  end
end
