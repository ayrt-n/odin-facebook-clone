#RSpec Configuration for systems testing with chrome
RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by ENV['SHOW_BROWSER'] ? :selenium_chrome : :selenium_chrome_headless
  end
end