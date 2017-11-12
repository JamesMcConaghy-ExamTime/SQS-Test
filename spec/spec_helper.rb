require "rspec"
require "watir" 
require "watir/rspec"
require "pry"

RESERVED_IVARS = %w(@browser).map(&:to_sym).freeze

RSpec.configure do |config|

	config.add_formatter('documentation')
	config.add_formatter(Watir::RSpec::HtmlFormatter)

	config.before :all, :watir do 
		@browser = Watir::Browser.new :safari
		Watir.always_locate = false
		@browser.cookies.clear
		@browser.driver.manage.timeouts.page_load = 5
		@browser.driver.manage.timeouts.implicit_wait = 0
		@browser.driver.manage.window.maximize
	end

	config.after :all, :watir do
		@browser.close if @browser
	end

	config.include Watir::RSpec::Helper, :watir

end