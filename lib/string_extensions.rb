#!/usr/bin/env ruby
#
# Some extensions to the built-in Ruby String class.
#
# == Authors
#
# * Ben Bleything <ben@bleything.net>
# * Various others as noted in the code
#
# == Copyright
#
# Copyright (c) 2008 Ben Bleything, except where noted.
#
# This code released under the terms of the MIT license.
#

class String
  ### NOTE: Stolen from ActiveSupport.  They hold the copyright.  Our
  ### modifications are making it a method on String and removing the
  ### lowerCamelCase option since we don't use it.
  ###
  ### +camelize+ converts strings to CamelCase.
  ###
  ### +camelize+ will also convert '/' to '::' which is useful for converting
  ### paths to namespaces.
  ###
  ### Examples
  ###   "active_record".camelize #=> "ActiveRecord"
  ###   "active_record/errors".camelize #=> "ActiveRecord::Errors"
  def camelize
    return self.gsub( /\/(.?)/ ) {
      "::" + $1.upcase
    }.
    gsub( /(^|_)(.)/ ) {
      $2.upcase
    }
  end

  ### NOTE: Stolen from ActiveSupport.  They hold the copyright.  The only
  ### modifications were to make it a String instance method instead of a
  ### function.
  ###
  ### The reverse of +camelize+. Makes an underscored form from the expression
  ### in the string.
  ###
  ### Changes '::' to '/' to convert namespaces to paths.
  ###
  ### Examples
  ###   "ActiveRecord".underscore #=> "active_record"
  ###   "ActiveRecord::Errors".underscore #=> active_record/errors
  def underscore
    return self.gsub( /::/, '/' ).
    gsub( /([A-Z]+)([A-Z][a-z])/, '\1_\2' ).
    gsub( /([a-z\d])([A-Z])/    , '\1_\2' ).
    tr( "-", "_" ).
    downcase
  end

end
