require 'development_mail_interceptor'

MAILER_CREDENTIALS = YAML.load(
  File.read(
    Rails.root.join('config', 'mailer_credentials.yml')
  )
)['settings']

ActionMailer::Base.default_url_options[:host] = "localhost:3000"
Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?
