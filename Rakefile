require 'rubygems'
require 'hoe'

Hoe.spec 'midiator' do
  developer 'Ben Bleything', 'ben@bleything.net'

  ### Use markdown for changelog and readme
  self.history_file = 'CHANGELOG.md'
  self.readme_file  = 'README.md'

  ### Depend on Platform
  self.extra_deps << [ 'Platform', '>= 0.4.0' ]

  ### Test with rspec
  self.extra_dev_deps << [ 'rspec', '>= 2.1.0' ]
  self.testlib = :rspec

end
