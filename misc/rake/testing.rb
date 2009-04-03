#!/usr/bin/env ruby
#
# Rake tasks related to testing.
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

require 'spec/rake/spectask'

desc "Run the RSpec suite"
Spec::Rake::SpecTask.new( :spec ) do |r|
  r.libs      = SPEC_FILES
  r.spec_opts = %w(--format specdoc --color)
end

namespace :spec do
  ### Run the specifications and generate coverage information
  Spec::Rake::SpecTask.new( :coverage ) do |r|
    r.rcov      = true
    r.rcov_dir  = 'coverage'
    r.rcov_opts = %w( -x Library\/Ruby,^spec )
    r.libs      = SPEC_FILES
  end
end
