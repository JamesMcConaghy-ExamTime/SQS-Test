require_relative "spec_helper.rb"
require_relative "locators.rb"

class Base_Helper

	attr_reader :browser

	def initialize(browser)
		@browser = browser
	end

	def goto(url)
		@browser.goto url
	end

	def locate(element, options = {})
		if !options.empty?
			element = element.gsub(/%{(.*?)}/) { options }
		end
		eval(element)
	end

end