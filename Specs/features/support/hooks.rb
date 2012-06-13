After("@itunes_stop") do
  puts "Stopping iTunes"
  tell_app("iTunes", "stop playing")
end
