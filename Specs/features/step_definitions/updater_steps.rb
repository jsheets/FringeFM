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

Then /^the (?:.+) application should be available$/ do
  @updater.isServiceAvailable.should == 1
end

Then /^the (?:.+) application should not be available$/ do
  @updater.isServiceAvailable.should == 0
end
