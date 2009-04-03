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

require File.join( File.dirname(__FILE__), 'lib', 'spec_helper.rb' )

describe MIDIator::Interface do
  before( :each ) do
    @driver_name = 'i_like_bees'

    @interface = MIDIator::Interface.new
    @driver_class = mock( "driver class" )
  end

  describe "auto-detects the correct driver for your platform" do
    before( :all ) do
      # remember platform so we can reset it later
      @ruby_platform = Platform::IMPL

      # suppress warnings (http://www.ruby-forum.com/topic/127608)
      $-v = nil
    end

    after( :all ) do
      # reset platform to whatever is correct for our platform
      Platform::IMPL = @ruby_platform

      # restore warnings (http://www.ruby-forum.com/topic/127608)
      $-v = false
    end

    it "selects WinMM for Windows" do
      Platform::IMPL = :mswin
      @interface.should_receive( :use ).with( :winmm )

      @interface.autodetect_driver
    end

    it "selects CoreMIDI for OSX" do
      Platform::IMPL = :macosx
      @interface.should_receive( :use ).with( :core_midi )

      @interface.autodetect_driver
    end

    it "selects ALSA for Linux" do
      Platform::IMPL = :linux
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
        mock( 'foo', :null_object => true )
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
