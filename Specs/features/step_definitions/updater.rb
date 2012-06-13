When /^I ask for the current track$/ do
  @song = @updater.fetchCurrentSong
  @song.should_not be_nil
  @song.error.should be_nil, "Should not receive error for valid last.fm user '#{@user_name}': #{@song.error}"
end

Then /^I get valid track info$/ do
  @song.track.should == @track_name
  @song.artist.should == @artist
  @song.album.should == @album
end

Given /^the "([^"]*)" application is shut down$/ do |app_name|
  tell_app("iTunes", "quit")

  # Take a breath.
  sleep 2
end

Then /^the "([^"]*)" application should not be running$/ do |app_name|
  is_running = application_running?("iTunes")
  is_running.should eql("false"), "Application #{app_name} is still running, but shouldn't be: #{is_running}"
end
