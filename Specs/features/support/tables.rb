# Helper methods for Cucumber table testing.

def validate_table(table, actual_values)
  rows = table.raw
  rows.each do |property_name, property_value_regex|
    value = actual_values[property_name]

    value.should_not be_nil, "Property '#{property_name}' should not be nil"
    value.to_s.should match(/^#{property_value_regex}$/),
                      "Property '#{property_name}' does not match '#{value}'"
  end
end
