#!/usr/bin/env ruby
#
# The MIDIator driver to interact with Windows Multimedia.  Taken more or less
# directly from Practical Ruby Projects.
#
# NOTE: as yet completely untested.
#
# == Authors
#
# * Topher Cyll
# * Ben Bleything <ben@bleything.net>
#
# == Copyright
#
# Copyright (c) 2008 Topher Cyll
#
# This code released under the terms of the MIT license.
#

require 'midiator'
require 'midiator/driver'
require 'midiator/driver_registry'

class MIDIator::Driver::WinMM < MIDIator::Driver
	module C
		extend DL::Importable
		dlload 'libasound.so'

		extern "int snd_rawmidi_open( void*, void*, char*, int )"
		extern "int snd_rawmidi_close( void* )"
		extern "int snd_rawmidi_write( void*, void*, int )"
		extern "int snd_rawmidi_drain( void*)"
	end

	def open
		@output = DL::PtrData.new( nil )
		C.snd_rawmidi_open( nil, @output.ref, "virtual", 0 )
	end

	def close
		C.snd_rawmidi_close( @output )
	end

	def message( *args )
		format = "C"* args.size
		bytes = args.pack( format ).to_ptr
		C.snd_rawmidi_write( @output, bytes, args.size )
		C.snd_rawmidi_drain( @output )
	end
end
