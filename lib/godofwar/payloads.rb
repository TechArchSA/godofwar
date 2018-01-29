#
# KING SABRI | @KINGSABRI
#

module GodOfWar
require 'json'
  #
  # All war internal operations
  #
  class Payloads

    Payload = Struct.new(:name, :desc, :os, :conf, :url, :ref, :path)


    # @!attribute [r] payloads_info [Hash] parsed content of 'payloads_info.json' which full information about available payloads
    # @!attribute [r] payloads [Array] array of available payloads
    # @!attribute [r] info [Hash] of information of the current payload
    attr_reader :payloads_info, :payloads, :info
    # @!attribute [rw] payload [String] the current payload name
    attr_accessor :payload

    # HOME =  File.dirname(__FILE__) + '../../payloads'
    HOME =  File.dirname(__FILE__) + File.join('/', '..', '..', '/payloads')
    # PAYLOADS = Dir.glob("#{HOME}/**/*")#.map{|d| d.split('/').last}
    # PAYLOADS = Dir.glob(File.join(HOME, "/**/*"))#.map{|d| d.split('/').last}
    # Dir.glob(HOME).map{|d| d.split('/').last}

    def initialize
      @payloads_info = JSON.parse(File.read("#{HOME}/payloads_info.json"))
    end

    def payloads
      @payloads_info.map do |payload, info |
        name = payload
        desc = info["desc"]
        os   = info["os"]
        conf = info["conf"]
        url  = info["url"]
        ref  = info["ref"]
        path = File.join(HOME, payload)
        Payload.new(name, desc, os, conf, url, ref, path)
      end
    end


    def setup_payload(host, port)

    end


    #
    # List all available payloads using folder name conversion
    #
    # @return Array
    #
    def list_payloads_pretty
      # dir.delete_if{|i| i.include?(".")}
      # Dir.glob(HOME).map{|d| d.split('/').last}
      payloads.map do |payload|
        if payload.conf["true"]
          payload.conf = payload.conf.values.first
        else
          payload.conf["false"] = 'No Settings required!'
        end

        "├── " + "#{payload.name}\n".bold   +
        "│   └── Information:\n"        +
        "│       ├── Description: #{payload.desc}\n" +
        "│       ├── OS:          #{payload.os}\n"   +
        "│       ├── Defaults:    #{payload.conf}\n" +
        "│       ├── Usage:       #{payload.url}\n"  +
        "│       ├── References:  #{payload.ref}\n"  +
        "│       └── Local Path:  #{payload.path}"
      end

    end











    #
    # Permanently Add a shell file to be stored in payloads list
    #
    # @param [String] war is the war name to be added
    # @return [Array] array of current payloads
    #
    def add(war)
      # Add a new directory in HOME and copy the new shell in that directory
      new_dir = Dir.mkdir File.join(HOME, war)
      File.copy_stream war, new_dir
    end



    # Permanently delete a shell file from the stored payloads list
    #
    # @param [String] war is the war name to be deleted
    # @return [Array] array of current payloads
    #
    def delete(war)
      Dir.rmdir File.join(HOME, war)
    end
    
  end
end

if __FILE__ == $0
  require 'pp'

  require_relative 'extensions'
  include GodOfWar::Extensions::Core::String
# pp GodOfWar::Payloads::HOME
  payloads = GodOfWar::Payloads.new
# pp payloads.payloads.map(&:name)
pp payloads.payloads.select{|payload| payload.name == 'reverse_shell_ui'}
  puts payloads.list_payloads_pretty
end

