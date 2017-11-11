require './SQS_Helper.rb'

class SQS < SQS_Helper

	sqs = nil

	describe "Challenging DOM", :watir do 

		before :all do
			sqs = SQS_Helper.new(@browser)
		end

		after :all do
			
		end
		
		context "Tests" do

			it "should verify the page title" do
				expect(@browser.title).to include ('The Internet')
			end

			it "should wait until the page has loaded and key elements appear" do
				sqs.page_ready?	
			end

			it "should be possible to click on the button, which should refresh the canvas" do
				canvas_element = element(id: 'canvas')
				canvas_element.exists?
				sqs.click_btn
				expect(canvas_element.stale?).to eq true
			end

			it "should be possible to click on the alert button, which should refresh the canvas" do
				canvas_element = element(id: 'canvas')
				canvas_element.exists?
				sqs.click_btn_alert
				expect(canvas_element.stale?).to eq true
			end

			it "should be possible to click on the success button, which should refresh the canvas" do
				canvas_element = element(id: 'canvas')
				canvas_element.exists?
				sqs.click_btn_success
				expect(canvas_element.stale?).to eq true
			end

			it "should be possible to cancel the deletion of a row, and it should remain" do
				pending("Delete doesnt work")
				row = sqs.select_row_by_lorem("Iuvaret0")
				sqs.delete_row(row, false)
				expect(row.exists?).to eq true
			end

			it "should be possible to select a random row, delete it, and it should no longer exist" do
				pending("Delete doesnt work")
				row = sqs.select_row_by_lorem("Iuvaret0")
				sqs.delete_row(row, true)
				expect(row.exists?).to eq false
			end

			it "should be possible to cancel the edits on a random row, ensuring the original remained" do
				pending("Edit Button doesnt work")
				row = sqs.select_random_row

				original = []
				row.tds.each do |td|
					original << td.text
				end

				sqs.edit_row(row, "lorem","ipsum","dolor","sit","amet","diceret", false)

				original.each_with_index do |text, i|
					expect(row.tds[i].text).to include text
				end
			end

			it "should be possible to save the edits on a random row, ensuring the new was saved" do
				pending("Edit Button doesnt work")
				row = sqs.select_random_row
				sqs.edit_row(row, "lorem","ipsum","dolor","sit","amet","diceret", true)

				["lorem","ipsum","dolor","sit","amet","diceret"].each_with_index do |text, i|
					expect(row.tds[i].text).to include text
				end
				
			end

			it "edited data should persist when refrehing the page" do
				pending("Edit Button doesnt work")
				row = sqs.select_random_row
				sqs.edit_row(row, "lorem","ipsum","dolor","sit","amet","diceret", true)
				@browser.refresh

				["lorem","ipsum","dolor","sit","amet","diceret"].each_with_index do |text, i|
					expect(row.tds[i].text).to include text
				end

			end

		end

	end

end