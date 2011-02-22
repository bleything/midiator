#!/usr/bin/env ruby
#
# Plays the amen break.  Demonstrates playing on a different channel and use
# of the MIDIator::Drums and MIDIator::Durations mixins.
#
# == Authors
#
# * Ben Bleything <ben@bleything.net>
#
# == Copyright
#
# Copyright (c) 2009 Ben Bleything
#
# This code released under the terms of the MIT license.
#

require 'midiator'

@midi = MIDIator::Interface.new
# @midi.autodetect_driver
@midi.use :dls_synth

# let's get some drums!
include MIDIator::Drums
@midi.control_change 32, 10, 1 # TR-808 is Program 26 in LSB bank 1
@midi.program_change 10, 26

# set up some tempo constants
tempo = 120
QuarterNote   = 60.0 / tempo
EighthNote    = QuarterNote / 2
SixteenthNote = EighthNote / 2

# a helper method!
def beat( note, duration = EighthNote )
  @midi.play note, duration, 10
end

# instrument shortcuts
bass   = BassDrum1
snare  = SnareDrum1
cymbal = RideCymbal1

# "chord" shortcuts
bass_cymbal  = [ bass,  cymbal ]
snare_cymbal = [ snare, cymbal ]

# as transcribed at http://www.onlinedrumlessons.com/main/2005/09/classic-break-beat.htm
loop do

  # first measure is repeated 
  2.times do
    # beat 1
    beat bass_cymbal
    beat bass_cymbal
  
    # beat 2
    beat snare_cymbal
    @midi.rest SixteenthNote
    beat snare, SixteenthNote
  
    # beat 3
    beat cymbal,      SixteenthNote
    beat snare,       SixteenthNote
    beat bass_cymbal, SixteenthNote
    beat bass,        SixteenthNote
  
    # beat 4
    beat snare_cymbal
    beat cymbal, SixteenthNote
    beat snare,  SixteenthNote
  end
  
  # third measure starts out like the first...
  # beat 1
  beat bass_cymbal
  beat bass_cymbal

  # beat 2
  beat snare_cymbal
  @midi.rest SixteenthNote
  beat snare, SixteenthNote

  # beat 3
  beat cymbal, SixteenthNote
  beat snare,  SixteenthNote
  beat bass_cymbal
  
  # beat 4
  beat cymbal
  beat snare_cymbal
  
  # and then the fourth measure goes off the rails
  # beat 1
  beat cymbal, SixteenthNote
  beat snare,  SixteenthNote
  beat bass_cymbal, SixteenthNote
  beat bass,        SixteenthNote
  
  # beat 2
  beat snare_cymbal
  beat cymbal, SixteenthNote
  beat snare,  SixteenthNote
  
  # beat 3
  beat cymbal, SixteenthNote
  beat snare,  SixteenthNote
  beat 
end


exit

loop do
  # first bar is repeated twice
  2.times do
    @midi.play BassDrum1,  EighthNote,    9
    @midi.play BassDrum1,  EighthNote,    9
    @midi.play SnareDrum1, EighthNote,    9
    @midi.rest             SixteenthNote
    @midi.play SnareDrum1, SixteenthNote, 9
    @midi.rest             SixteenthNote
    @midi.play SnareDrum1, SixteenthNote, 9
    @midi.play BassDrum1,  SixteenthNote, 9
    @midi.play BassDrum1,  SixteenthNote, 9
    @midi.play SnareDrum1, EighthNote,    9
    @midi.rest             EighthNote
  end

  # bar 3
  @midi.play BassDrum1,  EighthNote,    9
  @midi.play BassDrum1,  EighthNote,    9
  @midi.play SnareDrum1, EighthNote,    9
  @midi.rest             SixteenthNote
  @midi.play SnareDrum1, SixteenthNote, 9
  @midi.rest             SixteenthNote
  @midi.play SnareDrum1, SixteenthNote, 9
  @midi.play BassDrum1,  EighthNote,    9
  @midi.rest             EighthNote
  @midi.play SnareDrum1, EighthNote,    9

  # bar 4
  @midi.rest             EighthNote
  @midi.play BassDrum1,  SixteenthNote, 9
  @midi.play BassDrum1,  SixteenthNote, 9
  @midi.play SnareDrum1, EighthNote,    9
  @midi.rest             SixteenthNote
  @midi.play SnareDrum1, SixteenthNote, 9
  @midi.rest             SixteenthNote
  @midi.play SnareDrum1, SixteenthNote, 9
  @midi.play BassDrum1,  EighthNote,    9
  @midi.rest             EighthNote
  @midi.play BassDrum1,  EighthNote,    9

  # a little break
  @midi.rest HalfNote
end
