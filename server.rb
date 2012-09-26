#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'socket'
require File.dirname(__FILE__) + '/lib/packer'

module Vince
  class Server
    def initialize
      @s = TCPServer.open 19861024
      @client = []
      @packer = Vince::Packer.new
    end

    def msg
      loop do
        sock = @s.accept
        @client.push sock
        Thread.new sock do |client|
          client.puts 'Connected..'
          while msg = client.gets
            #解析器
            data = @packer.depack msg
            #生成器
            @client.each do |c|
              c.puts @packer.get_msg data
            end #end each
          end #end while
        end #end thread
      end #end loop
    end #end msg
  end #end class
end #end module
s = Vince::Server.new
s.msg
