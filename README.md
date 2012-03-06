# MIDIator

* http://github.com/bleything/midiator

## Warning! Dead Project Ahead!

As you've no doubt noticed, I've not been maintaining MIDIator for
some time. Frankly, I published this gem out of a personal need that
no longer exists, and then I lazily chose to neglect my obligation to
the community. I apologize for the lack of maintenance.

I **strongly** recommend that you migrate to Ari Russo's [unimidi]
library as soon as possible. It looks a lot nicer than MIDIator and
it's actively maintained.

[unimidi]: https://github.com/arirusso/unimidi

Thanks for the interest and support!

-Ben

## DESCRIPTION:

A nice Ruby interface to your system's MIDI services.

MIDIator was inspired by Topher Cyll's fantastic Practical Ruby Projects
book.  In it, Topher describes how to interact with the MIDI providers
in OSX, Linux, and Windows.  As I was reading the book, I noticed some
things I would do differently, which got me thinking that maybe it
would be valuable to package up my modifications to the book's code and
release it as a gem.

## FEATURES:

* Cross-platform system for MIDI output
* Built-in softsynth (OS X only, so far)

## INSTALL:

    $ [sudo] gem install midiator

## AUTHORS:

* Ben Bleything -- ben@bleything.net
* Topher Cyll -- http://www.cyll.org

## CREDITS:

Huge, huge credit goes to Topher Cyll, without whom I would have had
to figure all of this crap out for myself.  Apress also deserves some
credit; they released all the source in their book under the MIT
license.  That's a big deal and you should buy their books.

Props also go to the folks who have contributed patches.  In
alphabetical order:

* Giles Bowkett -- gilesb@gmail.com
* Ruben Medellin -- http://github.com/chubas
* Adam Murray -- adam@compusition.com
* Xavier Shay -- http://rhnh.net
* Jeremy Voorhis -- jvoorhis@gmail.com

## LICENSE:

Distributed under the terms of the MIT license.  See the LICENSE file
for complete text and details.

Portions of the code are excerpted from Topher Cyll's Practical Ruby
Projects.  That code is also released under the MIT license.  See the
LICENSE.prp file for complete text and details.
