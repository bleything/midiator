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
BASEDIR       = Pathname.new( __FILE__ ).expand_path.dirname.relative_path_from( Pathname.getwd )
LIBDIR        = BASEDIR + 'lib'
DOCDIR        = BASEDIR + 'docs'
MISCDIR       = BASEDIR + 'misc'
RCOVDIR       = BASEDIR + 'coverage'
PKGDIR        = BASEDIR + 'pkg'
SPECDIR       = BASEDIR + 'spec'
RAKE_TASKDIR  = MISCDIR + 'rake'

# File glob constants
SPEC_FILES = Pathname.glob( SPECDIR + '**/*_spec.rb' )
LIB_FILES  = Pathname.glob( LIBDIR + '**/*.rb'       )

$LOAD_PATH.unshift( LIBDIR )

require RAKE_TASKDIR + 'testing.rb'
require RAKE_TASKDIR + 'rdoc.rb'

task :default => [ :spec ]
