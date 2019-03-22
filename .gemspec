#!/usr/bin/env ruby
# stub: Interruptible ruby lib

=begin
Copyright 2019 Michal Papis <mpapis@gmail.com>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
=end

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "interruptible/version"

Gem::Specification.new do |s|
  s.email   = ["mpapis@gmail.com"]
  s.authors = ["Michal Papis"]
  s.name    = "interruptible"
  s.version = Interruptible::VERSION.dup
  s.license = "Apache-2.0"
  s.files   = Dir["lib/**/*.rb", "*.md", "LICENSE", "NOTICE"]
  s.required_ruby_version = ">= 2.0.0"
  s.required_rubygems_version = ">= 2.0.0"

  s.homepage = "https://github.com/mpapis/interruptible"
  s.summary = "Extension of throw/catch to preserve interruption when once interrupted with given signal."
end
