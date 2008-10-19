#!/usr/bin/env ruby
#
# Rakefile for MIDIator.
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

require 'pathname'
require 'rubygems'
require 'rake'

# Pathname constants
BASE_DIR      = Pathname.new( __FILE__ ).expand_path.dirname.relative_path_from( Pathname.getwd )
LIB_DIR       = BASE_DIR + 'lib'
EXAMPLE_DIR   = BASE_DIR + 'examples'
MISC_DIR      = BASE_DIR + 'misc'
SPEC_DIR      = BASE_DIR + 'spec'
RAKE_TASK_DIR = MISC_DIR + 'rake'

# File glob constants
SPEC_FILES    = Pathname.glob( SPEC_DIR    + '**/*_spec.rb' )
LIB_FILES     = Pathname.glob( LIB_DIR     + '**/*.rb'      )
EXAMPLE_FILES = Pathname.glob( EXAMPLE_DIR + '**/*.rb'      )
MISC_FILES    = Pathname.glob( MISC_DIR    + '**/*.rb'      )
RELEASE_FILES = SPEC_FILES + LIB_FILES + EXAMPLE_FILES + MISC_FILES

$LOAD_PATH.unshift( LIB_DIR )

require RAKE_TASK_DIR + 'testing.rb'
require RAKE_TASK_DIR + 'rdoc.rb'
require RAKE_TASK_DIR + 'packaging.rb'

task :default => [ :spec ]
