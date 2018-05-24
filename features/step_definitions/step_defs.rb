require 'selenium-webdriver'

options = Selenium::WebDriver::Firefox::Options.new(
  args: ['-headless']
)
driver = Selenium::WebDriver.for :firefox, options: options
wait = Selenium::WebDriver::Wait.new(:timeout => 10)

Givet("at jeg er på systemets forside") do
  driver.navigate.to "http://localhost:3000/"
end

Givet("trykker jeg på menupunktet \"Antal brugere\"") do
  driver.find_element(:id, "btn_antal_brugere").click
end

Så("kan kan se antallet af brugere er {int}") do |expected|
  actual = wait.until { driver.find_element(:id, "result").text.to_i }
  expect(actual).to eq(expected)
end

Givet("jeg trykker på menupunktet \"Top-10 refererende brugere\"") do
  driver.find_element(:id, "btn_top_10_referende_brugere").click
end

Så("kan jeg se at øverste række indeholder brugernavnet {string}") do |expected|
  wait.until { driver.find_element(:css, "#main-content div:not(.hidden) table") }
  actual = driver.find_element(:css, "#main-content div:not(.hidden) table tbody tr:first-child").text
  expect(actual).to match(/#{expected}/)
end

Så("kan jeg se at øverste række indeholder {int} indlæg") do |expected|
  wait.until { driver.find_element(:css, "#main-content div:not(.hidden) table") }
  actual = driver.find_element(:css, "#main-content div:not(.hidden) table tbody tr").text
  expect(actual).to match(/#{expected.to_s}/)
end

Så("kan jeg se at nederste række indeholder brugernavnet {string}") do |expected|
  wait.until { driver.find_element(:css, "#main-content div:not(.hidden) table") }
  actual = driver.find_element(:css, "#main-content div:not(.hidden) table tbody tr:last-child").text
  expect(actual).to match(/#{expected}/)
end

Så("kan jeg se at nederste række indeholder {int} indlæg") do |expected|
  wait.until { driver.find_element(:css, "#main-content div:not(.hidden) table") }
  actual = driver.find_element(:css, "#main-content div:not(.hidden) table tbody tr:last-child").text
  expect(actual).to match(/#{expected.to_s}/)
end

Givet("jeg trykker på menupunktet \"Top-10 indlæg\"") do
  driver.find_element(:id, "btn_top_ten_tweets").click
end

Givet("jeg trykker på knappen \"Top-10 positive\"") do
  wait.until { driver.find_element(:id, "btn_positive") }.click
end

Givet("jeg trykker på knappen \"Top-10 negative\"") do
  wait.until { driver.find_element(:id, "btn_negative") }.click
end

Givet("jeg trykker på menupunktet \"Top-10 aktive brugere\"") do
  driver.find_element(:id, "btn_most_active_users").click
end

Givet("jeg trykker på knappen \"Antal tweets\"") do
  wait.until { driver.find_element(:id, "btn_by_count") }.click

end

Givet("jeg trykker på knappen \"Længste besked\"") do
  wait.until { driver.find_element(:id, "btn_by_length") }.click
end

Givet("jeg trykker på menupunktet \"Top-10 populære brugere\"") do
  driver.find_element(:id, "btn_top_ten_mentioned_users").click
end



at_exit do
  driver.quit
end
