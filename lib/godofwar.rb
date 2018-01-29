# Standard libraries
require 'optparse'
require 'json'

# GodOfWar
require 'godofwar/version'
require 'godofwar/builder'
require 'godofwar/payloads'
require 'godofwar/extensions'


# Globals
module  GodOfWar
  # include GodOfWar::Utils

  String.class_eval do
    include Extensions::Core::String
  end
end
