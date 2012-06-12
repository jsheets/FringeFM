require "yaml"

def user_info
  yml_file = File.join(DATA_DIR, "user_info.yml")
  File.exist?(yml_file).should be_true, "data/user_info.yml file should exist; please create from data/user_info.sample.yml template"

  YAML.load_file(yml_file)
end

Given /^a last.fm API key$/ do
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

When /^I download the current track$/ do
  @updater = FFMLastFMUpdater.alloc.initWithUserName_apiKey(@user_name, @api_key)
  @song = @updater.fetchCurrentSong
  @song.should_not be_nil
  @song.error.should be_nil, "Should not receive error for valid last.fm user '#{@user_name}': #{@song.error}"
end

Then /^I get valid track info$/ do
  pending
end
