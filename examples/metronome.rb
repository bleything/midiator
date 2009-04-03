#!/usr/bin/env ruby
#
# A metronome that can run at any given tempo.
#
# == Synopsis
#
# $ ./metronome
# => starts a metronome running at 120bpm
#
# $ ./metronome 180
# => starts a metronome running at 180bpm
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

########################################################################
### S A N I T Y   C H E C K S
########################################################################

@tempo = 120.0

if input = ARGV[0]
  begin
    @tempo = Float( input )
  rescue ArgumentError => e
    $stderr.puts "'#{input}' is not a valid tempo.\n"
    $stderr.puts "Please specify the tempo in beats per minute " +
      "(bpm).  Fractional values are allowed!"

    exit 1
  end
end

require 'rubygems'

########################################################################
### M I D I A T O R   S E T U P
########################################################################

require 'midiator'
include MIDIator::Notes

@midi = MIDIator::Interface.new
@midi.autodetect_driver
@midi.instruct_user!
@midi.program_change 0, 115 # Wood block!

# trap interrupts to properly kill the timer
Signal.trap( "INT" ) { @timer.thread.exit! }

########################################################################
### T I M E R   S E T U P
########################################################################

# 60 / tempo gives us the delay (in seconds) between each beat.  Divide
# that again by 10 to give us our desired resolution.
@interval = 60.0 / @tempo
@timer = MIDIator::Timer.new( @interval / 10 )

def register_next_bang( time )
  @timer.at( time ) do |yielded_time|
    register_next_bang yielded_time + @interval
    @midi.play MiddleC
  end
end

puts "Starting metronome running at #{@tempo} bpm."
register_next_bang Time.now.to_f
@timer.thread.join
