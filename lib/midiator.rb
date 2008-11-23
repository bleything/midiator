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
# This code released under the terms of the MIT license.
#

module MIDIator
	VERSION = "0.3.0"
end

#####################################################################
###	E X T E R N A L   D E P E N D E N C I E S
#####################################################################
require 'rubygems'
require 'platform'

#####################################################################
###	C O R E   L I B R A R Y   E X T E N S I O N S
#####################################################################
require 'string_extensions'

#####################################################################
###	M I D I A T O R   C O R E
#####################################################################
require 'midiator/driver'
require 'midiator/driver_registry'
require 'midiator/exceptions'
require 'midiator/interface'
require 'midiator/timer'

##########################################################################
### S H O R T C U T   M O D U L E S
##########################################################################
require 'midiator/drums'
require 'midiator/notes'
