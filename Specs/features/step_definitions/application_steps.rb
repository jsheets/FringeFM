Given /^the "([^"]*)" application is running$/ do |app_name|
  tell_app(app_name, "run")
  sleep 2
end

Given /^the "([^"]*)" application is shut down$/ do |app_name|
  tell_app(app_name, "quit")
  sleep 2
end

Then /^the "([^"]*)" application should not be running$/ do |app_name|
  is_running = application_running?(app_name)
  is_running.should eql("false"), "Application #{app_name} is still running, but shouldn't be: #{is_running}"
end
