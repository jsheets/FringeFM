When /^I parse the Now Playing JSON$/ do
  @now_playing = FFMLastFmJson.alloc.initWithJson(@json)
  @now_playing.jsonText.should == @json
  #@now_playing.jsonText.to_s.should match(/Spock's Beard/), "JSON sanity check"
end

When /^the now-playing flag should be "([^"]*)"$/ do |is_playing|
  expected = (is_playing == "on") ? 1 : 0
  @now_playing.song.isPlaying.should == expected
end

When /^the "([^"]*)" should be "([^"]*)"$/ do |property_name, value|
  @now_playing.song.send(property_name).to_s.should == value
end

Then /^the error message should be "([^"]*)"$/ do |message|
  @now_playing.song.error.should == message
end

When /^should not have an error$/ do
  @now_playing.song.error.should be_nil
end
