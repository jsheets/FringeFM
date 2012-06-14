When /^a song is playing$/ do
  # AppleScript to start playing a song from user_info.yml
  user_info.should have_key("itunes"), "Unable to find itunes key in data/user_info.yml file: #{user_info.inspect}"

  # Get track info from yml config.
  @track_name = user_info["itunes"]["track_name"]
  @track_name.should_not be_nil, "Unable to find itunes[track_name] in data/user_info.yml file: #{user_info.inspect}"
  @artist = user_info["itunes"]["artist"]
  @artist.should_not be_nil, "Unable to find itunes[artist] in data/user_info.yml file: #{user_info.inspect}"
  @album = user_info["itunes"]["album"]
  @album.should_not be_nil, "Unable to find itunes[album] in data/user_info.yml file: #{user_info.inspect}"

  # Tell iTunes to play our track (stop it later in the After hook).
  tell_app("iTunes", "play track \"#{@track_name}\"")
end

When /^we are using the iTunes application updater$/ do
  @updater = FFMITunesUpdater.alloc.init
end
