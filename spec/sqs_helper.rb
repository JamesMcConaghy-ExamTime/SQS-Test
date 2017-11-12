require_relative "base_helper.rb"

class SQS_Helper < Base_Helper

	@browser = nil

	attr_reader :browser

	def initialize(browser)
		super
		goto "http://the-internet.herokuapp.com/challenging_dom"
	end

	def page_title
		 return @browser.title
	end

	def page_ready?
		locate(CONTENT).wait_until_present
		locate(TABLE).wait_until_present
		locate(CANVAS).wait_until_present
	end

	def click_btn
		locate(BUTTON).flash.click
		sleep(1)
	end

	def click_btn_alert
		locate(BUTTON_ALERT).flash.click
		sleep(1)
	end

	def click_btn_success
		locate(BUTTON_SUCCESS).flash.click
		sleep(1)
	end

	def select_random_row
		rows = []
		locate(TABLE_ROWS).each do |row|
			rows << row
		end
		row = rows.sample
		return row
	end

	def select_row_by_lorem(lorem)
		row = locate(ROW_BY_LOREM, lorem)
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
			#@browser.alert.ok
		else
			#@browser.alert.close
		end
	end

end