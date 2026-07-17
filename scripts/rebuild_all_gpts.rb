#!/usr/bin/env ruby
# frozen_string_literal: true

require "optparse"
require_relative "factory_support"

module FactoryRebuild
  module_function

  def rebuild(blueprint_dir:, output_root:, profiles_dir: File.join(LegendsFactory::REPO_ROOT, "config/profiles"), core_dir: File.join(LegendsFactory::REPO_ROOT, "core"), dry_run: false)
    blueprints = Dir[File.join(blueprint_dir, "*.yaml")].sort
    return [] if blueprints.empty?

    validated = blueprints.map do |blueprint|
      data = LegendsFactory.load_yaml(blueprint)
      LegendsFactory.validate_blueprint!(data, profiles_dir: profiles_dir, core_dir: core_dir)
      [blueprint, data]
    end
    duplicate_slugs = validated.group_by { |_blueprint, data| data.fetch("slug") }.select { |_slug, entries| entries.length > 1 }.keys
    raise "Duplicate blueprint slugs: #{duplicate_slugs.join(', ')}" unless duplicate_slugs.empty?
    return validated.map { |_blueprint, data| File.join(output_root, data.fetch("slug")) } if dry_run

    targets = []
    Dir.mktmpdir("legends-portfolio-rebuild") do |staging|
      validated.each do |blueprint, _data|
        LegendsFactory.build(
          blueprint_path: blueprint,
          output_root: staging,
          profiles_dir: profiles_dir,
          core_dir: core_dir,
          force: true
        )
      end
      FileUtils.mkdir_p(output_root)
      validated.each do |_blueprint, data|
        slug = data.fetch("slug")
        target = File.join(output_root, slug)
        FileUtils.rm_rf(target)
        FileUtils.mv(File.join(staging, slug), target)
        targets << target
      end
    end
    targets
  end
end

if $PROGRAM_NAME == __FILE__
  options = {
    blueprint_dir: File.join(LegendsFactory::REPO_ROOT, "gpts/blueprints"),
    output_root: File.join(LegendsFactory::REPO_ROOT, "gpts")
  }
  parser = OptionParser.new do |opts|
    opts.banner = "Usage: rebuild_all_gpts.rb [options]"
    opts.on("--blueprint-dir PATH", "Authorized blueprint registry") { |value| options[:blueprint_dir] = value }
    opts.on("--output-root PATH", "Generated GPT package root") { |value| options[:output_root] = value }
    opts.on("--profiles-dir PATH", "Profile source directory") { |value| options[:profiles_dir] = value }
    opts.on("--core-dir PATH", "Factory core directory") { |value| options[:core_dir] = value }
    opts.on("--dry-run", "Validate and list targets without writing") { options[:dry_run] = true }
  end
  parser.parse!
  targets = FactoryRebuild.rebuild(**options)
  puts targets.empty? ? "No authorized GPT blueprints found." : "Rebuilt #{targets.length} GPT package(s)."
  targets.each { |target| puts target }
end
