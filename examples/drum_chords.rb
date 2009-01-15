#!/usr/bin/env ruby
#
# Plays a simple polyphonic drumbeat.
#
# == Authors
#
# * David Brady <dbrady@shinybit.com>
#
# == Copyright
#
# Copyright (c) 2008 David Brady
#
# This code released under the terms of the MIT license.
#

require 'rubygems'
require 'midiator'
 
midi = MIDIator::Interface.new
midi.autodetect_driver
 
midi.control_change 32, 10, 1 # TR-808 is Program 26 in LSB bank 1
midi.program_change 10, 26
 
include MIDIator::Drums
 
song = [ BassDrum1,
  [BassDrum2, SnareDrum1],
  BassDrum1,
  [BassDrum1, SnareDrum1, SnareDrum2, CrashCymbal1]
]
riff = [ HighTom1, HighTom2, LowTom1, LowTom2 ]
 
# This starts to push the usability limit of play.
4.times do
  song.each do |note|
    midi.play note, 0.25, 10
  end
end
riff.each do |note|
  midi.play note, 0.067, 10
end
midi.play CrashCymbal2, 0.25, 10
 
4.times do
  song.each do |note|
    midi.play note, 0.25, 10
  end
end
