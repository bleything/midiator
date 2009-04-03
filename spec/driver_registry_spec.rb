#!/usr/bin/env ruby
#
# Contains the specifications for the MIDIator::DriverRegistry class.
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

describe MIDIator::DriverRegistry do
  before( :all ) do
    # alias MIDIator::Driver's inherited method out of the way and
    # redefine it as a no-op.  This prevents MIDIator::Driver from trying
    # to auto-register subclasses.
    MIDIator::Driver.instance_eval {
      class << self
        alias_method :old_inherited, :inherited
      end

      def self::inherited( klass )
        # no-op
      end
    }
  end

  after( :all ) do
    # move MIDIator::Driver's inherited method back into place
    MIDIator::Driver.instance_eval {
      class << self
        alias_method :inherited, :old_inherited
      end
    }
  end

  before( :each ) do
    @registry = MIDIator::DriverRegistry.instance

    @driver_fixture = {
      :a => "is for apple",
      :b => "is for bunches of apples"
    }
  end

  after( :each ) do
    @registry.instance_variable_set( :@drivers, nil )
  end

  it "is a Singleton" do
    lambda { MIDIator::DriverRegistry.new }.should raise_error
    MIDIator::DriverRegistry.should respond_to( :instance )
  end

  it "knows how many drivers are registered" do
    @registry.instance_variable_set( :@drivers, @driver_fixture )
    @registry.size.should == @driver_fixture.size
  end

  it "can be dereferenced as though it was a hash" do
    @registry.instance_variable_set( :@drivers, @driver_fixture )
    @driver_fixture.keys.each do |key|
      @registry[ key ].should == @driver_fixture[ key ]
    end
  end

  it "aliases #register_driver to #register and #<<" do
    register_driver = @registry.method( :register_driver )

    @registry.method( :<< ).should == register_driver
    @registry.method( :register ).should == register_driver
  end

  it "keeps track of registered drivers by name" do
    Bees       = Class.new( MIDIator::Driver )
    Sandwiches = Class.new( MIDIator::Driver )
    Guns       = Class.new( MIDIator::Driver )

    @registry.register( :bees,       Bees       )
    @registry.register( :sandwiches, Sandwiches )
    @registry.register( :guns,       Guns       )

    @registry[ :bees       ].should be( Bees       )
    @registry[ :sandwiches ].should be( Sandwiches )
    @registry[ :guns       ].should be( Guns       )
  end

  it "prevents anything other than a MIDIator::Driver subclass from being registered" do
    lambda {
      @registry.register( :failboat, String )
    }.should raise_error( ArgumentError, "Attempted to register something that is not a MIDIator::Driver" )

    lambda {
      @registry.register( :great_success, Class.new( MIDIator::Driver ) )
    }.should_not raise_error
  end

  it "prevents a single driver from being registered multiple times" do
    klass = Class.new( MIDIator::Driver )

    lambda {
      @registry.register( :first_try, klass )
    }.should_not raise_error

    lambda {
      @registry.register( :second_try, klass )
    }.should raise_error( ArgumentError, "Already registered #{klass.to_s} as 'first_try'." )
  end
end
