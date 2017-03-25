require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ordinateur
  def self.redis_url
    secrets.redis_url.present? ? URI(secrets.redis_url) : nil
  end

  def self.redis
    @redis ||= Redis.new(url: redis_url.to_s.presence, logger: Rails.logger)
  end

  def self.secrets
    Rails.application.secrets
  end

  class Application < Rails::Application
    config.responders.flash_keys = [ :success, :failure ]
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
