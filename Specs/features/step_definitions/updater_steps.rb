When /^I ask for the current track$/ do
  @song = @updater.fetchCurrentSong
  @song.should_not be_nil
  @song.errorText.should be_nil, "Should not receive error for valid last.fm user '#{@user_name}': #{@song.errorText}"
end

Then /^I get valid track info$/ do
  # If we have a specific value we're looking for (from user_info.yml), check for that
  # exact value. Otherwise, just make sure we have something there, so check for two or more characters.
  if @track_name
    @song.track.should == @track_name
  else
    @song.track.to_s.should match(/\w{2}/)
  end

  if @artist
    @song.artist.should == @artist
  else
    @song.artist.to_s.should match(/\w{2}/)
  end

  if @album
    @song.album.should == @album
  else
    @song.album.to_s.should match(/\w{2}/)
  end
end

Then /^the (?:.+) application should be available$/ do
  @updater.isServiceAvailable.should == 1
end

Then /^the (?:.+) application should not be available$/ do
  @updater.isServiceAvailable.should == 0
end
