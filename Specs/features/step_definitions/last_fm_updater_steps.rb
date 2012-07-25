require "yaml"

def user_info
  yml_file = File.join(DATA_DIR, "user_info.yml")
  File.exist?(yml_file).should be_true, "data/user_info.yml file should exist; please create from data/user_info.sample.yml template"

  YAML.load_file(yml_file)
end

#
# last.fm web API.
#

Given /^we have a last.fm API key$/ do
  # A bit dicey here, since these values shouldn't be checked into git.
  #
  # Reads API key from the YAML file data/user_info.yml. You'll
  # need to create it locally with your own API keys, using data/user_info.sample.yml
  # as a template.
  user_info.should have_key("last_fm"), "Unable to find last_fm key in data/user_info.yml file: #{user_info.inspect}"
  @api_key = user_info["last_fm"]["api_key"]
  @api_key.should_not be_nil, "Unable to find last_fm[api_key] in data/user_info.yml file: #{user_info.inspect}"

  @user_name = user_info["last_fm"]["user"]
  @user_name.should_not be_nil, "Unable to find last_fm[user] in data/user_info.yml file: #{user_info.inspect}"
end

When /^we are using the last.fm web updater$/ do
  @updater = FFMLastFMUpdater.alloc.initWithUserName_apiKey(@user_name, @api_key)
end

#
# last.fm desktop application.
#

Given /^a song is playing in the last.fm application$/ do
  pending
end

When /^we are using the last.fm application updater$/ do
  @updater = FFMLastFMAppUpdater.alloc.init
end
