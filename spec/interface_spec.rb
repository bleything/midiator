#!/usr/bin/env ruby
#
# Contains the specifications for the MIDIator::Interface class.
#
# == Authors
#
# * Ben Bleything <ben@bleything.net>
#
# == Contributors
#
# * Giles Bowkett
#
# == Copyright
#
# Copyright (c) 2008 Ben Bleything
#
# This code released under the terms of the MIT license.
#

require 'midiator'

describe MIDIator::Interface do
  before( :each ) do
    @driver_name = 'i_like_bees'

    @interface = MIDIator::Interface.new
    @driver_class = mock( "driver class" )
  end

  describe "auto-detects the correct driver for your platform" do
    before( :all ) do
      # remember platform so we can reset it later
      @ruby_platform = RUBY_PLATFORM

      # suppress warnings (http://www.ruby-forum.com/topic/127608)
      $-v = nil
    end

    after( :all ) do
      # reset platform to whatever is correct for our platform
      RUBY_PLATFORM = @ruby_platform

      # restore warnings (http://www.ruby-forum.com/topic/127608)
      $-v = false
    end

    it "selects WinMM for Windows/RubyInstaller" do
      RUBY_PLATFORM = "i386-mingw32"
      @interface.should_receive( :use ).with( :winmm )

      @interface.autodetect_driver
    end

    it "selects WinMM for Windows/cygwin" do
      RUBY_PLATFORM = "i386-cygwin"
      @interface.should_receive( :use ).with( :winmm )

      @interface.autodetect_driver
    end

    it "selects CoreMIDI for OSX" do
      RUBY_PLATFORM = "universal-darwin10.0"
      @interface.should_receive( :use ).with( :core_midi )

      @interface.autodetect_driver
    end

    it "selects ALSA for Linux" do
      RUBY_PLATFORM = "x86_64-linux"
      @interface.should_receive( :use ).with( :alsa )

      @interface.autodetect_driver
    end
  end

  describe "provides the #use method to load/specify a MIDI driver" do
    it "requires the driver's file from midiator/drivers" do
      path = "midiator/drivers/#{@driver_name}"
      @interface.should_receive( :require ).with( path )

      # stub out the rest of #use
      Object.should_receive( :module_eval ).and_return(
        mock( 'foo' ).as_null_object
      )

      @interface.use( @driver_name )
    end

    it "captures a LoadError and gives the user a slightly better message" do
      @interface.should_receive( :require ).and_raise( LoadError )

      lambda {
        @interface.use( @driver_name )
      }.should raise_error( LoadError, "Could not load driver '#{@driver_name.to_s}'.")
    end

    it "instantiates the driver's class" do
      @interface.stub!( :require )

      Object.should_receive( :module_eval ).with(
        "::MIDIator::Driver::ILikeBees"
      ).and_return( Class.new )

      @interface.use( @driver_name )
    end

    it "correctly spells MIDI if the driver name includes it" do
      @interface.stub!( :require )

      Object.should_receive( :module_eval ).with(
        "::MIDIator::Driver::SomeClassThatHasMIDIInItsName"
      ).and_return( Class.new )

      @interface.use( "some_class_that_has_midi_in_its_name" )
    end

    it "correctly spells ALSA when the ALSA driver is requested" do
      @interface.stub!( :require )

      Object.should_receive( :module_eval ).with(
        "::MIDIator::Driver::ALSA"
      ).and_return( Class.new )

      @interface.use( :alsa )
    end

    it "correctly spells WinMM when the WinMM driver is requested" do
      @interface.stub!( :require )

      Object.should_receive( :module_eval ).with(
        "::MIDIator::Driver::WinMM"
      ).and_return( Class.new )

      @interface.use( :winmm )
    end
    
    it "correctly spells DLSSynth when the DLSSynth driver is requested" do
      @interface.stub!( :require )
      
      Object.should_receive( :module_eval ).with(
        "::MIDIator::Driver::DLSSynth" 
      ).and_return( Class.new )
      
      @interface.use( :dls_synth )
    end
  end
end
