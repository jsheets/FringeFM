Given /^a JSON data string with a currently playing song$/ do
  json_file = File.join(DATA_DIR, "getrecenttracks-playing.json")
  @json = File.read(json_file).strip
end

Given /^a JSON data string with no currently playing songs$/ do
  json_file = File.join(DATA_DIR, "getrecenttracks-quiet.json")
  @json = File.read(json_file).strip
end

Given /^a JSON data string with an error message$/ do
  json_file = File.join(DATA_DIR, "error.json")
  @json = File.read(json_file).strip
end

When /^I parse the JSON$/ do
  @fm_json = FFMJson.alloc.initWithJson(@json)
end

Then /^I should find the JSON property "([^"]*)"$/ do |property_name|
  value = @fm_json.valueForProperty(property_name)
  value.should_not be_nil
end

Then /^I should find the JSON property "([^"]*)" with the values:$/ do |property_name, table|
  value = @fm_json.valueForProperty(property_name)
  value.should_not be_nil, "Property #{property_name} should exist"
  validate_table(table, value)
end

Then /^the JSON property "([^"]*)" should have (\d+) entries$/ do |property_name, array_size|
  @array_key_path = property_name
  @array = @fm_json.valueForProperty(@array_key_path)
  @array.should_not be_nil, "Property #{@array_key_path} should exist"
  @array.count.should == array_size.to_i
end

When /^track (\d+) should have JSON properties:$/ do |track_index, table|
  rows = table.raw
  rows.each do |track_key_path, property_value_regex|
    # Splice each track's property key path onto previous base key path.
    #  e.g. recenttracks.track[0].@attr.nowplaying
    full_key_path = "#{@array_key_path}[#{track_index}].#{track_key_path}"
    #puts "Track key path: #{full_key_path}"

    value = @fm_json.valueForProperty(full_key_path)

    value.should_not be_nil, "Property '#{full_key_path}' should exist"
    value.to_s.should match(/^#{property_value_regex}$/),
                      "Property '#{full_key_path}' does not match '#{value}'"
  end
end
