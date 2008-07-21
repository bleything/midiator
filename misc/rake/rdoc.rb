#!/usr/bin/env ruby
#
# Rake tasks for generating rdoc
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

require 'rake/rdoctask'

### Task: rdoc
Rake::RDocTask.new do |rdoc|
	rdoc.rdoc_dir = 'docs/rdoc'
	rdoc.title    = "MIDIator - a nice Ruby interface to your system's MIDI services."

	rdoc.options += [
		'-w', '4',
		'-SHN',
		'-i', BASEDIR.to_s,
		# '-f', 'darkfish',
		'-m', 'README',
		# '-W', 'http://opensource.laika.com/browser/thingfish/trunk/'
	  ]
	
	rdoc.rdoc_files.include 'README'
	rdoc.rdoc_files.include 'LICENSE'
	rdoc.rdoc_files.include 'LICENSE.prp'
	rdoc.rdoc_files.include LIB_FILES.collect {|f| f.relative_path_from(BASEDIR).to_s }
end
# task :rdoc do
# 	outputdir = DOCDIR + 'rdoc'
# 
# 	rmtree( targetdir )
# 	cp_r( outputdir, targetdir, :verbose => true )
# end
# task :clobber_rdoc do
# 	rmtree( STATICWWWDIR + 'api', :verbose => true )
# end
# 
