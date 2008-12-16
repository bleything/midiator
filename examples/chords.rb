require 'rubygems'
require 'midiator'
 
midi = MIDIator::Interface.new
midi.use("dls_synth")

include MIDIator::Notes

C4MAJ = [ C4, E4, G4 ]
F4MAJII = [ C4, F4, A4 ]
G4MAJ = [ D4, G4, B4 ]

song = [ C3, C4MAJ, C3, C4MAJ, F3, F4MAJII, F3, F4MAJII, G3, G4MAJ, G3, G4MAJ, C5, C4MAJ, C2, C4MAJ]

2.times do 
  song.each do |note|
    midi.play note, 0.25
  end
end

