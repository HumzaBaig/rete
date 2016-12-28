# get companies, titles, locations of listings that allow applying
# through glassdoor, so that you can check the position.text of current
# listing and skip if position has keywords like: 'Senior'

require_relative "../modules/selenium.rb"
require_relative "../modules/io.rb"

include IOStream
include Selenium

DRIVER = Selenium::DRIVER
WAIT = Selenium::WebDriver::Wait.new(timeout: 60)

FINAL_COUNT = IOStream::input_application_count

def handle_failure(err)
  puts "Something went wrong\n"
end

def close_browser
  DRIVER.quit
end

def glassdoor_signin(folder_name)
  signin_modal = DRIVER.find_element(css: 'span.signin.acctMenu')
  signin_modal.click

  sleep(1)

  email, password = IOStream::input_user_info(folder_name)

  email_input = DRIVER.find_element(id: 'signInUsername')
  email_input.send_keys(email)

  sleep(1)

  password_input = DRIVER.find_element(id: 'signInPassword')
  password_input.send_keys(password)

  signin_button = DRIVER.find_element(id: 'signInBtn')
  signin_button.click
end

def search_jobs
  location = IOStream::input_locations
  position = IOStream::input_positions

  location_input = DRIVER.find_element(id: "LocationSearch")
  location_input.clear
  location_input.send_keys(location)

  position_input = DRIVER.find_element(id: "KeywordSearch")
  position_input.send_keys(position)

  DRIVER.find_element(class: "search")
end

def get_job_info
  # glassdoor_job_listings selects only the listings where you can apply
  # directly through glassdoor
  glassdoor_job_listings = DRIVER.find_elements(class: 'applyText')

  glassdoor_job_listings.each.with_index do |listing, index|
    # break the loop if it reaches the end of the listings
    break if index >= glassdoor_job_listings.count

    listing.click

    sleep(1)

    begin
      ez_apply_button = DRIVER.find_element(class: 'ezApplyBtn')
    rescue
      # if 'ezApplyBtn' cannot be found, you can't apply through glassdoor
      # so skip the listing
      next
    end

    sleep(1)

    description = DRIVER.find_elements(
      css: 'div.jobDescriptionContent.desc'
    )
    ez_apply_button = DRIVER.find_element(class: 'ezApplyBtn')

    sleep(1)

    ez_apply_button.click

    sleep(1)
    application_count = apply(folder_name, application_count)
  end

  # moves to next page if it reaches end of listings AND final count not reached
  if application_count < FINAL_COUNT
    next_page_button = DRIVER.find_element(class: 'next')
    next_page_button.click
    get_job_info(folder_name)
  end
end

def apply(folder_name, current_count)
  current_count += 1

  name, email = IOStream::input_user_info(folder_name)
  coverletter = IOStream::input_coverletter(folder_name)

  name_input = DRIVER.find_element(id: 'ApplicantName')
  email_input = DRIVER.find_element(id: 'ApplicantEmail')
  coverletter_input = DRIVER.find_element(id: 'ApplicantCoverLetter')

  # Fills out application form
  name_input.clear
  name_input.send_keys(name)
  sleep(rand(1..3))
  email_input.clear
  email_input.send_keys(email)
  sleep(rand(1..3))
  coverletter_input.clear
  coverletter_input.send_keys(coverletter)
  sleep(rand(1..3))

  # Select resume to send
  resume_select = DRIVER.find_element(id: "ExistingResumeSelectBoxIt")
  resume_select.click
  sleep(7..12)
  resume_file = DRIVER.find_element(
    xpath: '//*[@id="ExistingResumeSelectBoxItOptions"]/li[2]'
  )
  resume_file.click

  # This line will submit the application
  DRIVER.find_element(id: 'SubmitBtn').click

  current_count #return updated count
end

def completion_message
  puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  puts "  #{FINAL_COUNT} applications completed!"
  puts "   Please check your inbox for proof."
  puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
end

DRIVER.get("https://www.glassdoor.com/index.htm")

sleep(10)
user = IOStream::create_folder
glassdoor_signin(user)
sleep(1)
search_jobs.click
sleep(1)
get_job_info(user)
completion_message
close_browser
