require 'capybara/poltergeist'

# use poltergeist
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, js_errors: false)
end
Capybara.default_driver = :poltergeist

Capybara.configure do |config|
  config.javascript_driver = :poltergeist
  config.ignore_hidden_elements = true
  config.default_max_wait_time = 5
end

# transactional fixtures for poltergeist
class ActiveRecord::Base
  mattr_accessor :shared_connection
  @@shared_connection = nil
  def self.connection
    @@shared_connection || retrieve_connection
  end
end
ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection
