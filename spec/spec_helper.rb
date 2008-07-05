#!/usr/bin/env ruby
#
# Helpers etc for the spec suite.
#
# == Authors
# 
# * Ben Bleything <bbleything@laika.com>
# 
# == Copyright
#
# Copyright (c) 2008 LAIKA, Inc.
# 
# This code released under the terms of the BSD license.
# 
# == Version
#
#  $Id$
#

require 'rubygems'
require 'spec'

$: << File.expand_path(File.join(File.dirname(__FILE__),"..","lib"))

require 'midiator'
