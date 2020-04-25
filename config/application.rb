require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Weleve
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.i18n.default_locale = :ja
    unless Rails.env.production?
      # config.load_defaults 5.2
      # config.web_console.whitelisted_ips = '61.89.88.135'
    end
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    
    config.generators do |g|
      g.test_framework :rspec,
      fixtures: false,
      view_specs: false,
      helper_specs: false,
      routing_specs: false
    end
  end
end



