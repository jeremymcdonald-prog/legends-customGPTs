#!/usr/bin/env ruby
# frozen_string_literal: true

require "optparse"
require_relative "factory_support"

options = {}
parser = OptionParser.new do |opts|
  opts.banner = "Usage: build_gpt_package.rb --blueprint PATH --output-root PATH [options]"
  opts.on("--blueprint PATH", "GPT blueprint YAML") { |value| options[:blueprint_path] = value }
  opts.on("--output-root PATH", "Directory that will receive <slug>/") { |value| options[:output_root] = value }
  opts.on("--profiles-dir PATH", "Profile source directory") { |value| options[:profiles_dir] = value }
  opts.on("--core-dir PATH", "Factory core directory") { |value| options[:core_dir] = value }
  opts.on("--platform ID", "Override blueprint export platform") { |value| options[:platform] = value }
  opts.on("--force", "Replace an existing generated target") { options[:force] = true }
end
parser.parse!
parser.abort("Missing --blueprint") unless options[:blueprint_path]
parser.abort("Missing --output-root") unless options[:output_root]

target = LegendsFactory.build(**options)
puts "Generated and validated #{target}"
