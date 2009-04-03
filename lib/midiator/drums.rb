#!/usr/bin/env ruby
#
# A module that you can include to get access to constants representing known
# drum note numbers.
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

module MIDIator::Drums # this file does not rdoc well, so uhh.... :nodoc:

  ##########################################################################
  ### G E N E R A L   M I D I   D R U M   N O T E S
  ##########################################################################
  BassDrum1     = 36  ;;;  LongGuiro     = 74  ;;;  OpenHiHat     = 46
  BassDrum2     = 35  ;;;  LongWhistle   = 72  ;;;  OpenHighConga = 63
  Cabasa        = 69  ;;;  LowAgogo      = 68  ;;;  OpenTriangle  = 81
  ChineseCymbal = 52  ;;;  LowBongo      = 61  ;;;  PedalHiHat    = 44
  Claves        = 75  ;;;  LowConga      = 64  ;;;  RideBell      = 53
  ClosedHiHat   = 42  ;;;  LowTimbale    = 66  ;;;  RideCymbal1   = 51
  Cowbell       = 56  ;;;  LowTom1       = 43  ;;;  RideCymbal2   = 59
  CrashCymbal1  = 49  ;;;  LowTom2       = 41  ;;;  ShortGuiro    = 73
  CrashCymbal2  = 57  ;;;  LowWoodBlock  = 77  ;;;  ShortWhistle  = 71
  HandClap      = 39  ;;;  Maracas       = 70  ;;;  SideStick     = 37
  HighAgogo     = 67  ;;;  MidTom1       = 47  ;;;  SnareDrum1    = 38
  HighBongo     = 60  ;;;  MidTom2       = 45  ;;;  SnareDrum2    = 40
  HighTimbale   = 65  ;;;  MuteCuica     = 78  ;;;  SplashCymbal  = 55
  HighTom1      = 50  ;;;  MuteHighConga = 62  ;;;  Tambourine    = 54
  HighTom2      = 48  ;;;  MuteTriangle  = 80  ;;;  VibraSlap     = 58
  HighWoodBlock = 76  ;;;  OpenCuica     = 79

end
