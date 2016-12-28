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
