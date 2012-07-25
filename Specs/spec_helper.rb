#
#  spec_helper.rb
#  RubyTesting
#
#  Created by John Sheets on 2/04/12.
#  Copyright 2012 FourFringe. All rights reserved.
#
# MIT License
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

require "rspec"

if defined?(MACRUBY_VERSION)
  # MacRuby
  puts "Running specs with MacRuby."
  framework 'Specs'
  puts "Running tests with MacRuby."
else
  # RubyCocoa
    puts "Running specs with RubyCocoa."
  build_dir = ENV["FRAMEWORK_PATH"] || "."
  specs_framework = File.join(build_dir, "Specs.framework")

  require 'osx/cocoa'

  puts "Linking to test framework: #{specs_framework}"
  puts "Specs.framework missing?..." unless File.exist?(specs_framework)

  OSX.require_framework specs_framework
  include OSX
  puts "Running tests with RubyCocoa."
end

SPECS_DIR = File.expand_path(File.dirname(__FILE__)) unless defined?(SPECS_DIR)
DATA_DIR = File.join(SPECS_DIR, "data") unless defined?(DATA_DIR)

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
#Dir["#{SPECS_DIR}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :spec
end

puts "Done loading config"
