#!/usr/bin/env ruby
#
# Rake tasks related to packaging.
#
# == Authors
#
# * Ben Bleything <ben@bleything.net>
#
# == Copyright
#
# Copyright (c) 2008 Ben Bleything
#
# This code released under the terms of the MIT license.
#

require 'midiator'

require 'rake/packagetask'
require 'rake/gempackagetask'

### Task: gem
gemspec = Gem::Specification.new do |gem|
  gem.name      = "midiator"
  gem.version   = MIDIator::VERSION

  gem.summary     = "MIDIator - A a nice Ruby interface to your system's MIDI services."
  gem.description = "MIDIator provides an OS-agnostic way to send live MIDI messages to " +
            "your machine's MIDI playback system."

  gem.authors  = "Ben Bleything"
  gem.email    = "ben@bleything.net"
  gem.homepage = "http://projects.bleything.net/projects/show/midiator"

  gem.rubyforge_project = 'midiator'

  gem.has_rdoc = true

  gem.files        = RELEASE_FILES.
    collect {|f| f.relative_path_from(BASE_DIR).to_s }
  gem.test_files   = SPEC_FILES.
    collect {|f| f.relative_path_from(BASE_DIR).to_s }

  gem.add_dependency 'Platform', [">= 0.4.0"]
end

Rake::GemPackageTask.new( gemspec ) do |task|
  task.gem_spec = gemspec
  task.need_tar = false
  task.need_tar_gz = true
  task.need_tar_bz2 = true
  task.need_zip = true
end
