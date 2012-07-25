After("@itunes_kill") do
  puts "Stopping iTunes"
  tell_app("iTunes", "quit")
end

After("@spotify_kill") do
  puts "Stopping Spotify"
  tell_app("Spotify", "quit")
end

After("@mog_kill") do
  puts "Stopping Mog"
  tell_app("Mog", "quit")
end

After("@rdio_kill") do
  puts "Stopping Rdio"
  tell_app("Rdio", "quit")
end

After("@lastfm_kill") do
  puts "Stopping Last.fm"
  tell_app("Last.fm", "quit")
end

