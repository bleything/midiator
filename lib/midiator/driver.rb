require 'midiator'
require 'midiator/driver_registry'

class MIDIator::Driver
	def self::inherited( driver_class )
		driver_name = driver_class.to_s.underscore
		MIDIator::DriverRegistry.instance.register( driver_name, driver_class )
	end
end