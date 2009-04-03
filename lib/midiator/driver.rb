#!/usr/bin/env ruby
#
# The abstractish superclass of all MIDIator MIDI drivers.
#
# == Authors
#
# * Ben Bleything <ben@bleything.net>
#
# == Contributors
#
# * Jeremy Voorhis <jvoorhis@gmail.com>
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
  ### M I D I   C O M M A N D   C O N S T A N T S
  ##########################################################################

  # Note on
  ON  = 0x90

  # Note off
  OFF = 0x80

  # Polyphonic aftertouch
  PA  = 0xa0

  # Control change
  CC  = 0xb0

  # Program change
  PC  = 0xc0

  # Channel aftertouch
  CA  = 0xd0

  # Pitch bend
  PB  = 0xe0

  ##########################################################################
  ### M A G I C   H O O K S
  ##########################################################################

  ### Auto-registers subclasses of MIDIator::Driver with the driver registry.
  def self::inherited( driver_class )
    driver_name = driver_class.to_s.underscore
    MIDIator::DriverRegistry.instance.register( driver_name, driver_class )
  end


  ##########################################################################
  ### I N T E R F A C E   A P I
  ##########################################################################
  # These methods are the same across all drivers and are the interface that
  # MIDIator::Interface interacts with.
  ##########################################################################

  ### Do any pre-open setup necessary.  Often will not be overridden.
  def initialize
    open
  end


  ### Shortcut to send a note_on message.
  def note_on( note, channel, velocity )
    message( ON | channel, note, velocity )
  end


  ### Shortcut to send a note_off message.
  def note_off( note, channel, velocity = 0 )
    message( OFF | channel, note, velocity )
  end


  ### Shortcut to send a polyphonic aftertouch message for an individual note.
  def aftertouch( note, channel, pressure )
    message( PA | channel, note, pressure )
  end


  ### Shortcut to send a control change.
  def control_change( number, channel, value )
    message( CC | channel, number, value )
  end


  ### Shortcut to send a program_change message.
  def program_change( channel, program )
    message( PC | channel, program )
  end


  ### Shortcut to send a channel aftertouch message.
  def channel_aftertouch( channel, pressure )
    message( CA | channel, pressure )
  end


  ### Shortcut to send a pitch bend message.
  def pitch_bend( channel, value )
    message( PB | channel, value )
  end
  alias bend pitch_bend


  ##########################################################################
  ### D R I V E R   A P I
  ##########################################################################
  # subclasses must implement these methods.
  ##########################################################################
  protected
  ##########################################################################

  ### Open the channel to the MIDI service.
  def open
    raise NotImplementedError, "You must implement #open in your driver."
  end


  ### Close the channel to the MIDI service.
  def close
    raise NotImplementedError, "You must implement #close in your driver."
  end


  ### Send MIDI message to the MIDI service.
  def message( *args )
    raise NotImplementedError, "You must implement #message in your driver."
  end


  ### The only non-required method.  Override this to give the user instructions
  ### if necessary.
  def instruct_user!
  end

end
