require 'rubygems'
require 'hoe'

Hoe.plugin :git, :doofus, :seattlerb

Hoe.spec 'midiator' do
  developer 'Ben Bleything', 'ben@bleything.net'

  ### Use markdown for changelog and readme
  self.history_file = 'CHANGELOG.md'
  self.readme_file  = 'README.md'

  ### Test with rspec
  self.extra_dev_deps << [ 'rspec', '>= 2.1.0' ]
  self.testlib = :rspec

  ### build zip files too
  self.need_zip = true

end
