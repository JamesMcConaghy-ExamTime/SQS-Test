require "./spec_helper.rb"

class SQS_Helper

	@browser = nil

	attr_reader :browser

	def initialize(browser)
		@browser = browser
		@browser.goto "http://the-internet.herokuapp.com/challenging_dom"
	end

	def page_ready?
		@browser.div(id: 'content').wait_until_present
		@browser.table.wait_until_present
		@browser.canvas.wait_until_present
	end

	def click_btn
		@browser.div(id: 'content').divs(class: 'row')[0].links(class: 'button')[0].flash.click
		sleep(1)
	end

	def click_btn_alert
		@browser.div(id: 'content').divs(class: 'row')[0].link(class: ['button', 'alert']).flash.click
		sleep(1)
	end

	def click_btn_success
		@browser.div(id: 'content').divs(class: 'row')[0].link(class: ['button', 'success']).flash.click
		sleep(1)
	end

	def select_random_row
		rows = []
		@browser.table.tbody.rows.each do |row|
			rows << row
		end
		row = rows.sample
		return row
	end

	def select_row_by_lorem(lorem)
		row = @browser.table.tbody.td(text: lorem).parent
		return row
	end

	def edit_row(row, lorem, ipsum, dolor, sit, amet, diceret, save)
		row.link(:text => 'edit').flash.click
		row.tds[0].set lorem
		row.tds[1].set ipsum
		row.tds[2].set dolor
		row.tds[3].set sit
		row.tds[4].set amet
		row.tds[5].set diceret
		if save
			row.link(:text => 'save').flash.click
		else
			row.link(:text => 'cancel').flash.click
		end
	end

	def delete_row(row, confirm)
		row.link(:text => 'delete').flash.click
		if confirm
			@browser.alert.ok
		else
			@browser.alert.close
		end
	end

end