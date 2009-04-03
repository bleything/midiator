#!/usr/bin/env ruby
#
# The MIDIator driver to interact with ALSA on Linux.  Taken more or less
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

require 'dl/import'

require 'midiator'
require 'midiator/driver'
require 'midiator/driver_registry'

class MIDIator::Driver::ALSA < MIDIator::Driver # :nodoc:
  # tell the user they need to connect to their output
  def instruct_user!
    $stderr.puts "[MIDIator] Please connect the MIDIator output port to your input"
    $stderr.puts "[MIDIator] of choice.  You can use qjackctl or aconnect to do so."
    $stderr.puts "[MIDIator]"
    $stderr.puts "[MIDIator] Press enter when you're done."

    gets # wait for the enter
  end


  module C # :nodoc:
    extend DL::Importable
    dlload 'libasound.so'

    extern "int snd_rawmidi_open(void*, void*, char*, int)"
    extern "int snd_rawmidi_close(void*)"
    extern "int snd_rawmidi_write(void*, void*, int)"
    extern "int snd_rawmidi_drain(void*)"
  end

  def open
    @output = DL::PtrData.new(nil)
    C.snd_rawmidi_open(nil, @output.ref, "virtual", 0)
  end

  def close
    C.snd_rawmidi_close(@output)
  end

  def message(*args)
    format = "C" * args.size
    bytes = args.pack(format).to_ptr
    C.snd_rawmidi_write(@output, bytes, args.size)
    C.snd_rawmidi_drain(@output)
  end
end
