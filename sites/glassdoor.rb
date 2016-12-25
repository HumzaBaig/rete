# get companies, titles, locations of listings that allow applying
# through glassdoor, so that you can check the position.text of current
# listing and skip if position has keywords like: 'Senior'

require_relative "../modules/selenium.rb"
require_relative "../modules/io.rb"

include IOStream
include Selenium

DRIVER = Selenium::DRIVER
WAIT = Selenium::WebDriver::Wait.new(timeout: 60)

def handle_failure(err)
  puts "Something went wrong\n"
end

def closeBrowser
  DRIVER.quit
end

def glassdoor_signin
  signin_modal = DRIVER.find_element(css: 'span.signin.acctMenu')
  signin_modal.click

  sleep(1)

  email, password = IOStream::input_login

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
  location_input.send_keys("San Francisco, CA")

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
    apply
  end

  # moves to next page if it reaches end of listings
  next_page_button = DRIVER.find_element(class: 'next')
  next_page_button.click
  get_job_info
end

def apply
  name, email = IOStream::input_name_email
  coverletter = IOStream::input_coverletter

  name_input = DRIVER.find_element(id: 'ApplicantName')
  email_input = DRIVER.find_element(id: 'ApplicantEmail')
  coverletter_input = DRIVER.find_element(id: 'ApplicantCoverLetter')

  # Fills out application form
  name_input.clear
  name_input.send_keys(name)
  email_input.clear
  email_input.send_keys(email)
  coverletter_input.clear
  coverletter_input.send_keys(coverletter)

  # Select resume to send
  resume_select = DRIVER.find_element(id: "ExistingResumeSelectBoxIt")
  resume_select.click
  sleep(1)
  resume_file = DRIVER.find_element(
    xpath: '//*[@id="ExistingResumeSelectBoxItOptions"]/li[2]'
  )
  resume_file.click

  # This line will submit the application
  DRIVER.find_element(id: 'SubmitBtn').click
end

DRIVER.get("https://www.glassdoor.com/index.htm")

sleep(10)
glassdoor_signin
sleep(1)
search_jobs.click
sleep(1)
get_job_info
sleep(90000)
