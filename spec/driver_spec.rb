#!/usr/bin/env ruby
#
# Contains the specifications for the MIDIator::Driver class.
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

require File.join( File.dirname(__FILE__), 'lib', 'spec_helper.rb' )

describe MIDIator::Driver do
  it "automatically registers subclasses" do
    SomeCoolDriver = Class.new
    SomeCoolDriver.should_receive( :< ).with( MIDIator::Driver ).and_return( true )

    # call inherited directly since we can't set up expectations ahead of
    # time with Class.new( MIDIator::Driver )
    MIDIator::Driver.inherited( SomeCoolDriver )

    MIDIator::DriverRegistry.instance[ "some_cool_driver" ].should be( SomeCoolDriver )
  end
end
