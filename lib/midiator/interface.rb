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
	
	### Automatically select a driver to use
	def autodetect_driver
		self.use( :winmm     ) if RUBY_PLATFORM.include? 'win32'
		self.use( :core_midi ) if RUBY_PLATFORM.include? 'darwin'
		self.use( :alsa      ) if RUBY_PLATFORM.include? 'linux'
	end


	### Attempts to load the MIDI system driver called +driver_name+.
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
		
		# special case for the ALSA driver
		driver_class.sub!( /Alsa/, 'ALSA' )
		
		# special case for the WinMM driver
		driver_class.sub!( /Winmm/, 'WinMM' )

		# this little trick stolen from ActiveSupport.  It looks for a top-
		# level module with the given name.
		@driver = Object.module_eval( "::#{driver_class}" ).new
	end


	### A little shortcut method for playing the given +note+ for the specified
	### +duration+.
	def play( note, duration = 0.1, channel = 0, velocity = 100 )
		@driver.note_on( note, channel, velocity )
		sleep duration
		@driver.note_off( note, channel, velocity )
	end


	### Does nothing for +duration+ seconds.
	def rest( duration = 0.1 )
		sleep duration
	end

	#######
	private
	#######

	### Checks to see if the currently-loaded driver knows how to do +method+ and
	### passes the message on if so.  Raises an exception (as normal) if not.
	def method_missing( method, *args )
		raise NoMethodError, "Neither MIDIator::Interface nor #{@driver.class} " +
			"has a '#{method}' method." unless @driver.respond_to? method

		return @driver.send( method, *args )
	end
	
end
