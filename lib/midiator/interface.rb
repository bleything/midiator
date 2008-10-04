#!/usr/bin/env ruby
#
# The main entry point into MIDIator.  Create a MIDIator::Interface object and
# off you go.
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

class MIDIator::Interface
	attr_reader :driver

	def use( driver_name )
		driver_path = "midiator/drivers/#{driver_name.to_s}"
		
		begin
			require driver_path
		rescue LoadError => e
			raise LoadError,
				"Could not load driver '#{driver_name}'."
		end
		
		# Fix two side-effects of the camelization process... first, change
		# instances of Midi to MIDI.  This fixes the acronym form but doesn't
		# change, for instance, 'timidity'.
		#
		# Second, the require path is midiator/drivers/foo, but the module
		# name is Driver singular, so fix that.
		driver_class = driver_path.camelize.
			gsub( /Midi/, 'MIDI' ).
			sub( /::Drivers::/, '::Driver::')

		# this little trick stolen from ActiveSupport.  It looks for a top-
		# level module with the given name.
		@driver = Object.module_eval( "::#{driver_class}" ).new
	end
	
	def play( note, duration = 0.1, channel = 0, velocity = 100 )
		@driver.note_on( note, channel, velocity )
		sleep duration
		@driver.note_off( note, channel, velocity )
	end
	
	def rest( duration = 0.1 )
		sleep duration
	end
	
	def change_patch( channel, program )
		@driver.program_change( channel, program )
	end
end
