#!/usr/bin/env rake
require 'bundler/gem_tasks'
require 'adminlte-rails/source_file'
desc "Update with almasaeed2010's AdminLTE theme"
task :update do
  files = SourceFile.new
  files.cleanup
  files.fetch
  files.convert
end

task :convert do
  files = SourceFile.new
  files.convert
end