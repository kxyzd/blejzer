# frozen_string_literal: true

require_relative 'blejzer/version'

require_relative 'blejzer/types'

require_relative 'blejzer/dumper'
require_relative 'blejzer/specifictypes/number'
require_relative 'blejzer/specifictypes/uoarr'
require_relative 'blejzer/specifictypes/struct'
require_relative 'blejzer/specifictypes/string'

# Module for object serialization.
module Blejzer
  class Error < StandardError; end
  # Your code goes here...
end

def Blejzer(object)
  Blejzer::Dumper.Blejzer(object)
end
