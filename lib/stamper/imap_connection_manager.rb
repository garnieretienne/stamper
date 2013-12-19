require 'net/imap'

module Stamper

  class IMAPConnectionManager

    attr_reader :store, :connection_id

    def initialize(host: nil, port: 993, ssl: true, user: nil, password: nil)
      @host = host
      @port = port
      @ssl = ssl
      @user = user
      @password = password
      @store = Stamper::Utils::MemoryStore.instance
      @connection_id = "#{user}@#{host}"
    end

    def open
      if store.find(connection_id)
        return store.get(connection_id)
      else
        imap = Net::IMAP.new(@host, port: @port, ssl: @ssl)
        imap.login(@user, @password)
        return store.set(connection_id, imap)
      end
    end
  end
end