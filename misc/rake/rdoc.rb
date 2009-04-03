#!/usr/bin/env ruby
#
# Rake tasks for generating rdoc
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

require 'rake/rdoctask'

# uncomment for hanna!
# gem 'mislav-hanna'
# require 'hanna'

### Task: rdoc
Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'docs/rdoc'
  rdoc.title    = "MIDIator - a nice Ruby interface to your system's MIDI services."

  rdoc.options += [
    '-w', '4',
    '-SHNa',
    '-i', BASE_DIR.to_s,
    # '-T', 'hanna',    # uncomment for hanna!
    '-m', 'README',
    '-W', 'http://projects.bleything.net/repositories/changes/midiator/',
    ]

  rdoc.rdoc_files.include 'README'
  rdoc.rdoc_files.include 'LICENSE'
  rdoc.rdoc_files.include 'LICENSE.prp'
  rdoc.rdoc_files.include LIB_FILES.collect {|f| f.relative_path_from(BASE_DIR).to_s }
end
