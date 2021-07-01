require_relative "boot"

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
Bundler.require(*Rails.groups)

module KCSCApi
  class Application < Rails::Application
    config.load_defaults 6.1
    config.api_only = true
    config.generators do |generate|
      generate.helper false
      generate.assets false
      generate.skip_routes false
      generate.routing_specs false
      generate.controller_specs false
      generate.request_specs false
    end
  end
end
