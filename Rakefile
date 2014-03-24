#!/usr/bin/env bundle exec rake
require 'bundler'
Bundler.setup
Bundler::GemHelper.install_tasks

task :default => :spec

desc 'Run specs (default)'
task :spec do
  sh 'rspec', *ARGV
end

desc 'generate yard docs'
task :yard do
  sh 'yardoc'
end
task :rdoc => :yard

desc 'generate doc'
task :doc => [:yard]

namespace :bump do
  version_file = 'lib/i18n_locales/version.rb'
  old_version = I18nLocales::VERSION

  desc 'X+1.0.0 - bump to next major version (major changes)'
  task :major do
    if old_version =~ /([0-9]+.)[0-9]+.[0-9]+/
      new_version = "#{Integer($2)+1}.0.0"
      sh "sed -i '' 's/#{old_version}/#{new_version}/' #{version_file}"
      sh "git add #{version_file}"
      sh "git commit -s -S -m '#{new_version}'"
    else
      sh 'false'
    end
  end

  desc 'X.Y+1.0 - bump to next minor version (minor API changes)'
  task :minor do
    if old_version =~ /([0-9]+.)([0-9]+.)[0-9]+/
      new_version = "#{$1}#{Integer($2)+1}.0"
      sh "sed -i '' 's/#{old_version}/#{new_version}/' #{version_file}"
      sh "git add #{version_file}"
      sh "git commit -s -S -m '#{new_version}'"
    else
      sh 'false'
    end
  end

  task :dot do
    if old_version =~ /([0-9]+.[0-9]+.)([0-9]+)/
      new_version = "#{$1}#{Integer($2)+1}"
      sh "sed -i '' 's/#{old_version}/#{new_version}/' #{version_file}"
      sh "git add #{version_file}"
      sh "git commit -s -S -m '#{new_version}'"
    else
      sh 'false'
    end
  end
end

desc 'X.Y.Z+1 - bump to next dot version (minor, backward compatible fixes)'
task :bump => 'bump:dot'

desc 'Setup development environment'
task :setup do
  Bundler.with_clean_env do
    sh 'bundle package --all'
    sh ' bundle --local --deployment'
  end
end

desc 'Remove development environment'
task 'setup:remove' do
  sh 'rm -rf .bundle vendor Gemfile.lock'
end
