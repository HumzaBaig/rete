require "selenium-webdriver"

module Selenium

  DRIVER = Selenium::WebDriver.for :chrome

  # inadequate error method
  def handle_failure
    puts "Error"
  end

  # possibly unecessary due to Ruby web handling
  def closeBrowser
    DRIVER.quit
  end

end
