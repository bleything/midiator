#!/usr/bin/env ruby
#
# Rake tasks related to testing.
#
# == Authors
# 
# * Ben Bleything <bbleything@laika.com>
# 
# == Copyright
#
# Copyright (c) 2008 LAIKA, Inc.
# 
# This code released under the terms of the BSD license.
# 
# == Version
#
#  $Id$
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
		r.libs      = SPEC_FILES
	end
end
