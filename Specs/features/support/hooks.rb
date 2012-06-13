After("@itunes_kill") do
  puts "Stopping iTunes"
  tell_app("iTunes", "stop playing")
end
