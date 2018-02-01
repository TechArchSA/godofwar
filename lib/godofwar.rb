# Standard libraries
require 'optparse'
require 'json'
require 'zip'
require 'fileutils'

# GodOfWar
require 'godofwar/version'
require 'godofwar/builder'
require 'godofwar/payloads'
require 'godofwar/extensions'
require 'godofwar/utils'


# Globals
module  GodOfWar
  # include GodOfWar::Utils
  String.class_eval do
    include Extensions::Core::String
  end
end
