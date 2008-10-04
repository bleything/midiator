#!/usr/bin/env ruby
#
# A collection of exceptions used by MIDIator.
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

### Raised when the selected driver is unable to find any available MIDI
### destinations.
class MIDIator::NoMIDIDestinations < RuntimeError ; end