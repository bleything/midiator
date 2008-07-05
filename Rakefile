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
# This code released under the terms of the BSD license.
#

require 'pathname'
require 'rubygems'
require 'rake'

# Pathname constants
BASEDIR       = Pathname.new( __FILE__ ).expand_path.dirname.relative_path_from( Pathname.getwd )
LIBDIR        = BASEDIR + 'lib'
MISCDIR       = BASEDIR + 'misc'
RCOVDIR       = BASEDIR + 'coverage'
PKGDIR        = BASEDIR + 'pkg'
SPECDIR       = BASEDIR + 'spec'
RAKE_TASKDIR  = MISCDIR + 'rake'

# File glob constants
SPEC_FILES    = Pathname.glob( SPECDIR + '**/*_spec.rb' )

$LOAD_PATH.unshift( LIBDIR )

require RAKE_TASKDIR + 'testing.rb'

task :default => [ :spec ]
