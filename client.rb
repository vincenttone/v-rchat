#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'socket'
require File.dirname(__FILE__) + '/lib/packer'

module Vince
  class Client

    def initialize
      begin
        @s = TCPSocket.open 'localhost', 19861024
      rescue
        puts 'The server is offline...'
        exit
      end
      @packer = Vince::Packer.new
      @user = 'somebody'
      get_user_name
    end

    def get_user_name
      puts 'Please input your username:'
      while user = gets.chomp
        if user != ''
          @user = user.encode('utf-8')
          break
        else
          puts 'Username again:'
        end
      end
      @s.puts @packer.pack 1, @user, 'login'
    end

    #显示控制
    def show
      local_code = Encoding.locale_charmap
      while sin = @s.gets
        puts sin.force_encoding(local_code)
      end
    end

    #输入控制
    def put_in
      while uin = gets.chomp
        if uin != '\q'
          #数据组装
          data = @packer.pack 10, @user, uin.encode('utf-8')
          #data = data.to_s
          #数据发送
          @s.puts data
        else
          @s.close
          exit
        end
      end
    end

  end
end

c = Vince::Client.new
Thread.new { c.show }
c.put_in
