Given /^the "([^"]*)" application is running$/ do |app_name|
  tell_app("iTunes", "run")
  sleep 2
end

Given /^the "([^"]*)" application is shut down$/ do |app_name|
  tell_app("iTunes", "quit")
  sleep 2
end

Then /^the "([^"]*)" application should not be running$/ do |app_name|
  is_running = application_running?("iTunes")
  is_running.should eql("false"), "Application #{app_name} is still running, but shouldn't be: #{is_running}"
end
