#!/usr/bin/env ruby
#
# Helpers etc for the spec suite.
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

require 'rubygems'
require 'spec'

$: << File.expand_path( File.join( File.dirname(__FILE__), '..', '..', 'lib' ) )

require 'midiator'
