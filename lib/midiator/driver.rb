#!/usr/bin/env ruby
#
# The abstractish superclass of all MIDIator MIDI drivers.
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
require 'midiator/driver_registry'

class MIDIator::Driver
	
	##########################################################################
	### C O N S T A N T S
	##########################################################################
	
	# MIDI command constants
	ON  = 0x90
	OFF = 0x80
	PC  = 0xc0

	##########################################################################
	### M A G I C   H O O K S
	##########################################################################
	
	# Auto-registers subclasses of MIDIator::Driver with the driver registry
	def self::inherited( driver_class )
		driver_name = driver_class.to_s.underscore
		MIDIator::DriverRegistry.instance.register( driver_name, driver_class )
	end
	
	##########################################################################
	### D R I V E R   A P I
	##########################################################################
	# subclasses must implement these methods.
	##########################################################################
	
	def open
		raise NotImplementedError, "You must implement #open in your driver."
	end
	
	def close
		raise NotImplementedError, "You must implement #close in your driver."
	end
	
	def message( *args )
		raise NotImplementedError, "You must implement #message in your driver."
	end

	
	##########################################################################
	### I N T E R F A C E   A P I
	##########################################################################
	# These methods are the same across all drivers and are the interface that
	# MIDIator::Interface interacts with.
	##########################################################################
	
	def initialize
		open
	end
	
	def note_on( note, channel, velocity )
		message( ON | channel, note, velocity )
	end
	
	def note_off( note, channel, velocity )
		message( OFF | channel, note, velocity )
	end
	
	def program_change( channel, preset )
		message( PC | channel, preset )
	end
end