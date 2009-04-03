#!/usr/bin/env ruby
#
# A hash-like register of all loaded drivers.
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

require 'singleton'
require 'midiator'

class MIDIator::DriverRegistry
  include Singleton

  ### Stores the given +klass+ in the <tt>@drivers</tt> hash, keyed by +name+.
  ### Typically called via MIDIator::Driver's +inherited+ hook.
  def register_driver( name, klass )
    @drivers ||= {}

    raise ArgumentError, "Attempted to register something that is not a MIDIator::Driver" unless
      klass < MIDIator::Driver

    @drivers.each do |existing_name, existing_klass|
      raise ArgumentError, "Already registered #{existing_klass.to_s} as '#{existing_name}'." if
        existing_klass == klass
    end

    @drivers[ name ] = klass
  end
  alias register register_driver
  alias <<       register_driver


  ### Returns the number of drivers currently registered.
  def size
    return @drivers.size
  end


  ### Included to make the registry quack like a hash. Delegates to the
  ### <tt>@drivers</tt> hash.
  def []( name )
    return @drivers[ name ]
  end

end
