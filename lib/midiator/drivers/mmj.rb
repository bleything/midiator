# The MIDIator driver for JRuby on OSX.
#
# == Authors
#
# * Jeremy Voorhis
#
# == Copyright
#
# Copyright (c) 2008 Jeremy Voorhis
#
# This code released under the terms of the MIT license.
#

class MIDIator::Driver::Mmj < MIDIator::Driver # :nodoc:
  include Java
  include_package 'de.humatic.mmj'
  
  def outputs
    MidiSystem.get_outputs.inject([{},0]) { |(map, i), out|
      [map.update(out => i), i+1]
    }.first
  end
  
	def open(output = 0)
    @out = MidiSystem.open_midi_output(output)
	end
  
	def message(*args)
    @out.send_midi(args.to_java(:byte))
	end
  
	def close
    MidiSystem.close_midi_system
	end
end
