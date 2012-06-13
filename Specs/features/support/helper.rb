# Run an AppleScript command.
def tell_app(app_name, applescript_command)
  %x{osascript -e 'tell application "#{app_name}" to #{applescript_command}'}
end

def application_running?(app_name)
  # Returns "true" or "false".
  tell_app("System Events", "(name of processes) contains \"#{app_name}\"").strip
end
