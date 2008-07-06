#!/usr/bin/env ruby
#
# A Ruby library for interacting with system-level MIDI services.
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

require 'string_extensions'

module MIDIator
	VERSION = "0.0.1"
end

require 'midiator/interface'
require 'midiator/driver'
require 'midiator/driver_registry'
require 'midiator/notes'
