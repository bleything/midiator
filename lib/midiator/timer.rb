#!/usr/bin/env ruby
#
# A timer that allows you to schedule notes to be played in the future.
#
# == Authors
#
# * Topher Cyll
# * Ben Bleything <ben@bleything.net>
#
# == Copyright
#
# Copyright (c) 2008 Ben Bleything
#
# This code released under the terms of the MIT license.
#

class MIDIator::Timer
  attr_reader :resolution, :queue, :thread

  ### Create a new Timer object that ticks every +resolution+ seconds.
  def initialize( resolution )
    @resolution = resolution
    @queue = []

    @thread = Thread.new do
      loop do
        dispatch
        sleep @resolution
      end
    end
  end


  ### Empty the queue
  def flush
    @queue.clear
  end


  ### Add a new job to be performed at +time+.
  def at( time, &block )
    time = time.to_f if time.kind_of? Time
    @queue.push [ time, block ]
  end

  #######
  private
  #######

  ### Check to see if there is work to perform in this timeslice and
  ### do it if so.
  def dispatch
    now = Time.now.to_f

    # move "ready" work out of the queue
    ready, @queue = @queue.partition {|time, proc| time <= now }

    # call all of the "ready" jobs, passing in the time
    ready.each {|time, proc| proc.call( time ) }
  end

end
