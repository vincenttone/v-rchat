module Vince
  class Packer
    def pack(code, user, uin)
      data = {
        :head=>{:t=>code, :u=>user},
        :body=>{:msg=>uin}
      }
      data.to_s
      #data = Marshal.dump data
    end

    def depack(data)
      eval(data)
      #data = Marshal.load msg
    end

    def get_msg(data)
      msg = case data[:head][:t]
            when nil then nil
            when 1 then data[:head][:u] + ' come in. Welcome!'
            when 10 then data[:head][:u] + ' -> ' + data[:body][:msg]
            end
      msg
    end
  end
end
