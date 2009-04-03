#!/usr/bin/env ruby
#
# A copy of the chromatic scale example which uses the OS X built-in synth.
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
require 'midiator'

midi = MIDIator::Interface.new
midi.use :dls_synth
midi.instruct_user!

include MIDIator::Notes

scale = [ C4, Cs4, D4, Eb4, E4, F4, Fs4, G4, Gs4, A4, Bb4, B4,
          C5, Cs5, D5, Eb5, E5, F5, Fs5, G5, Gs5, A5, Bb5, B5 ]

scale.each do |note|
  midi.play note
end

scale.reverse.each do |note|
  midi.play note
end
